#!/usr/bin/env bash
# CRMEB 越南站数据库升级脚本（仅 SQL，幂等）
# 默认根目录: /www/wwwroot/cremb_shops/cjx_shop
# 升级包和sh脚本都在默认根目录下
# 用法：
#   bash upgrade_crmeb_db.sh                  # 正式执行（跳过 021 演示区划 / demo）
#   bash upgrade_crmeb_db.sh --dry-run        # 只列出将执行的文件
#   bash upgrade_crmeb_db.sh --with-seed-vn   # 额外执行 021_region_seed_vn.sql
#   bash upgrade_crmeb_db.sh --with-demo      # 额外执行 demo/001_demo_data.sql
#   bash upgrade_crmeb_db.sh --skip-backup    # 跳过 mysqldump（不推荐）
#
# 读取同目录 crmeb/.env 中的 DATABASE 配置；SQL 目录：crmeb/database/vn/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIVE_DIR="${SCRIPT_DIR}/crmeb"
SQL_DIR="${LIVE_DIR}/database/vn"
ENV_FILE="${LIVE_DIR}/.env"
BACKUP_ROOT="${SCRIPT_DIR}/_upgrade_backup"
STAMP="$(date +%Y%m%d_%H%M%S)"

DRY_RUN=0
WITH_SEED_VN=0
WITH_DEMO=0
SKIP_BACKUP=0

log() { printf '[%s] %s\n' "$(date '+%F %T')" "$*"; }
die() { log "ERROR: $*"; exit 1; }

usage() {
  sed -n '2,12p' "$0"
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage ;;
    --dry-run) DRY_RUN=1; shift ;;
    --with-seed-vn) WITH_SEED_VN=1; shift ;;
    --with-demo) WITH_DEMO=1; shift ;;
    --skip-backup) SKIP_BACKUP=1; shift ;;
    *) die "未知参数: $1" ;;
  esac
done

[[ -f "$ENV_FILE" ]] || die "找不到 $ENV_FILE"
[[ -d "$SQL_DIR" ]] || die "找不到 SQL 目录: $SQL_DIR（请先完成代码升级）"

# 兼容 LF / CRLF / 仅 CR
env_get() {
  local key="$1"
  tr '\r' '\n' < "$ENV_FILE" | awk -v k="$key" '
    {
      line=$0
      if (line ~ /^[[:space:]]*#/ || line ~ /^[[:space:]]*$/) next
      if (line ~ /^\[/) next
      n = index(line, "=")
      if (!n) next
      key = substr(line, 1, n - 1)
      val = substr(line, n + 1)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
      gsub(/^["'\'']|["'\'']$/, "", val)
      if (key == k) { print val; exit }
    }
  '
}

DB_HOST="$(env_get HOSTNAME)"; DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="$(env_get HOSTPORT)"; DB_PORT="${DB_PORT:-3306}"
DB_USER="$(env_get USERNAME)"
DB_PASS="$(env_get PASSWORD)"
DB_NAME="$(env_get DATABASE)"

[[ -n "$DB_USER" && -n "$DB_NAME" ]] || die "无法从 .env 解析数据库账号"

mapfile -t SQL_FILES < <(
  find "$SQL_DIR" -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.sql' | sort | while read -r f; do
    base="$(basename "$f")"
    # 默认跳过演示区划种子
    if [[ "$base" == "021_region_seed_vn.sql" && "$WITH_SEED_VN" -eq 0 ]]; then
      continue
    fi
    echo "$f"
  done
)
[[ ${#SQL_FILES[@]} -gt 0 ]] || die "未找到可执行的 NNN_*.sql"

log "=========================================="
log "库:       ${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
log "SQL目录:  $SQL_DIR"
log "文件数:   ${#SQL_FILES[@]}"
log "021种子:  $([ "$WITH_SEED_VN" -eq 1 ] && echo YES || echo SKIP)"
log "demo:     $([ "$WITH_DEMO" -eq 1 ] && echo YES || echo SKIP)"
log "模式:     $([ "$DRY_RUN" -eq 1 ] && echo DRY-RUN || echo APPLY)"
log "=========================================="

if [[ "$DRY_RUN" -eq 1 ]]; then
  for f in "${SQL_FILES[@]}"; do
    echo "  $(basename "$f")"
  done
  [[ "$WITH_DEMO" -eq 1 && -f "${SQL_DIR}/demo/001_demo_data.sql" ]] && echo "  demo/001_demo_data.sql"
  log "DRY-RUN 结束（未改库）"
  exit 0
fi

# 连通性
export MYSQL_PWD="$DB_PASS"
mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -N -e "SELECT 1" "$DB_NAME" >/dev/null \
  || die "无法连接数据库 ${DB_NAME}"

BACKUP_DIR="${BACKUP_ROOT}/${STAMP}_db"
mkdir -p "$BACKUP_DIR"
DONE_LOG="${BACKUP_DIR}/sql_applied.log"
: > "$DONE_LOG"

if [[ "$SKIP_BACKUP" -eq 0 ]]; then
  log "[1/3] 备份数据库 -> ${BACKUP_DIR}/db_${DB_NAME}.sql.gz"
  mysqldump --no-tablespaces -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" \
    --single-transaction --quick --default-character-set=utf8mb4 \
    "$DB_NAME" | gzip -c > "${BACKUP_DIR}/db_${DB_NAME}.sql.gz"
  log "备份完成: $(du -h "${BACKUP_DIR}/db_${DB_NAME}.sql.gz" | awk '{print $1}')"
else
  log "[1/3] 跳过库备份"
fi

log "[2/3] 按序执行 SQL"
for f in "${SQL_FILES[@]}"; do
  name="$(basename "$f")"
  log "  >> $name"
  if ! mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" \
      --default-character-set=utf8mb4 "$DB_NAME" < "$f"; then
    echo "$(date '+%F %T') FAIL $name" >> "$DONE_LOG"
    die "SQL 失败: $name （备份: ${BACKUP_DIR}/db_${DB_NAME}.sql.gz）"
  fi
  echo "$(date '+%F %T') OK $name" >> "$DONE_LOG"
done

if [[ "$WITH_DEMO" -eq 1 ]]; then
  DEMO="${SQL_DIR}/demo/001_demo_data.sql"
  if [[ -f "$DEMO" ]]; then
    log "  >> demo/001_demo_data.sql"
    mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" \
      --default-character-set=utf8mb4 "$DB_NAME" < "$DEMO" \
      || die "demo SQL 失败"
    echo "$(date '+%F %T') OK demo/001_demo_data.sql" >> "$DONE_LOG"
  else
    log "警告: 未找到 demo SQL，跳过"
  fi
fi

log "[3/3] 清理语言/接口相关 cache 标记 + runtime"
mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" --default-character-set=utf8mb4 "$DB_NAME" \
  -e "DELETE FROM eb_cache WHERE \`key\` IN ('lang_version') OR \`key\` LIKE 'api_lang_%';" 2>/dev/null || true

if [[ -d "${LIVE_DIR}/runtime" ]]; then
  find "${LIVE_DIR}/runtime" -mindepth 1 -maxdepth 1 ! -name '.gitignore' -exec rm -rf {} + 2>/dev/null || true
fi

# 验收抽查
log "验收抽查:"
mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" --table --default-character-set=utf8mb4 "$DB_NAME" <<'SQL' || true
SELECT 'tables' AS check_item, COUNT(*) AS cnt FROM information_schema.TABLES
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME IN (
      'eb_order_blacklist','eb_store_product_region_price','eb_phone_country',
      'eb_i18n_content','eb_i18n_glossary','eb_system_currency','eb_system_exchange_rate_log'
    );
SELECT 'order_is_cod' AS check_item, COUNT(*) AS cnt FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='eb_store_order' AND COLUMN_NAME='is_cod';
SELECT 'user_locale' AS check_item, COUNT(*) AS cnt FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='eb_user' AND COLUMN_NAME='locale';
SELECT 'city_country_code' AS check_item, COUNT(*) AS cnt FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='eb_system_city' AND COLUMN_NAME='country_code';
SELECT file_name, is_default, status FROM eb_lang_type WHERE is_del=0 ORDER BY id;
SELECT COUNT(*) AS currency_rows FROM eb_system_currency;
SELECT COUNT(*) AS phone_country_rows FROM eb_phone_country;
SQL

unset MYSQL_PWD

log "=========================================="
log "数据库升级完成"
log "执行日志: $DONE_LOG"
log "库备份:   ${BACKUP_DIR}/db_${DB_NAME}.sql.gz"
log "回滚示例: gunzip -c ${BACKUP_DIR}/db_${DB_NAME}.sql.gz | mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USER} -p ${DB_NAME}"
log "=========================================="
