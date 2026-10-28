#!/usr/bin/env bash
# CRMEB 同目录增量升级脚本（仅代码，不执行任何 SQL）
# 默认根目录: /www/wwwroot/cremb_shops/cjx_shop
# 升级包和sh脚本都在默认根目录下
# 用法：
#   bash upgrade_crmeb.sh crmeb-upgrade-261026.zip
#   bash upgrade_crmeb.sh crmeb-upgrade-261026.zip --full
#   bash upgrade_crmeb.sh crmeb-upgrade-261026.zip --dry-run
#   bash upgrade_crmeb.sh --restore-from _upgrade_backup/20261026_051446/crmeb_code.tar.gz
#   bash upgrade_crmeb.sh --restore-from .../crmeb_code.tar.gz --then crmeb-upgrade-261026.zip --full
#
# 选项：
#   --dry-run           只演练，不改线上
#   --full              rsync 带 --delete（仍保护保留项）；默认仅覆盖/新增
#   --skip-code-backup  跳过代码备份（不推荐）
#   --no-clear-runtime  不清 runtime 缓存
#   --owner user:group  升级后 chown（默认 www:www）
#   --restore-from TAR  先从升级前代码包恢复（再可选 --then 升级包）
#   --then ZIP          与 --restore-from 联用：恢复后再打升级包
#
# 保留不覆盖：.env / public/uploads / runtime / backup / .user.ini / install.lock
# 支持 Windows 打的反斜杠路径 zip。数据库请自行同步。

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIVE_DIR="${SCRIPT_DIR}/crmeb"
BACKUP_ROOT="${SCRIPT_DIR}/_upgrade_backup"
WORK_ROOT="${SCRIPT_DIR}/_upgrade_work"
STAMP="$(date +%Y%m%d_%H%M%S)"
OWNER="www:www"

DRY_RUN=0
FULL_SYNC=0
SKIP_CODE_BACKUP=0
CLEAR_RUNTIME=1
ZIP_ARG=""
RESTORE_FROM=""
THEN_ZIP=""

log()  { printf '[%s] %s\n' "$(date '+%F %T')" "$*"; }
die()  { log "ERROR: $*"; exit 1; }

usage() {
  sed -n '2,22p' "$0"
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage ;;
    --dry-run) DRY_RUN=1; shift ;;
    --full) FULL_SYNC=1; shift ;;
    --skip-code-backup) SKIP_CODE_BACKUP=1; shift ;;
    --no-clear-runtime) CLEAR_RUNTIME=0; shift ;;
    --owner) OWNER="${2:-}"; shift 2 ;;
    --restore-from) RESTORE_FROM="${2:-}"; shift 2 ;;
    --then) THEN_ZIP="${2:-}"; shift 2 ;;
    --sql-vn|--sql-demo|--skip-db-backup)
      die "已移除 SQL 相关参数（$1）。数据库请自行同步。" ;;
    *.zip) ZIP_ARG="$1"; shift ;;
    *) die "未知参数: $1（用 --help 查看）" ;;
  esac
done

abs_path() {
  local p="$1"
  if [[ "$p" = /* ]]; then echo "$p"; else echo "${SCRIPT_DIR}/${p}"; fi
}

resolve_zip() {
  local z prefer
  if [[ -n "$ZIP_ARG" ]]; then
    z="$(abs_path "$ZIP_ARG")"
    [[ -f "$z" ]] || die "找不到升级包: $z"
    echo "$z"
    return
  fi
  # 优先 crmeb-upgrade-*.zip，其次最新 crmeb-*.zip
  prefer="$(ls -1t "${SCRIPT_DIR}"/crmeb-upgrade-*.zip 2>/dev/null | head -1 || true)"
  if [[ -n "$prefer" ]]; then echo "$prefer"; return; fi
  z="$(ls -1t "${SCRIPT_DIR}"/crmeb-*.zip 2>/dev/null | head -1 || true)"
  [[ -n "$z" ]] || die "同目录未找到升级包，请指定 zip"
  echo "$z"
}

# 解压 zip（兼容 Windows 反斜杠路径）到目标目录，返回 crmeb 源码路径打印到 stdout 最后一行前用 log
extract_zip_to() {
  local zip_file="$1" dest="$2"
  rm -rf "$dest"
  mkdir -p "$dest"
  python3 - "$zip_file" "$dest" <<'PY'
import sys, zipfile
from pathlib import Path
zf_path, dest = sys.argv[1], Path(sys.argv[2])
with zipfile.ZipFile(zf_path) as zf:
    for info in zf.infolist():
        name = info.filename.replace("\\", "/").lstrip("/")
        if not name or name.endswith("/"):
            if name:
                (dest / name).mkdir(parents=True, exist_ok=True)
            continue
        out = dest / name
        out.parent.mkdir(parents=True, exist_ok=True)
        with zf.open(info) as src, open(out, "wb") as dst:
            dst.write(src.read())
PY
}

find_crmeb_src() {
  local root="$1"
  if [[ -d "${root}/crmeb/app" || -f "${root}/crmeb/composer.json" ]]; then
    echo "${root}/crmeb"
  elif [[ -d "${root}/app" || -f "${root}/composer.json" ]]; then
    echo "$root"
  else
    local one
    one="$(find "$root" -mindepth 1 -maxdepth 1 -type d | head -1 || true)"
    if [[ -n "$one" && -d "${one}/crmeb" ]]; then
      echo "${one}/crmeb"
    elif [[ -n "$one" && -d "${one}/app" ]]; then
      echo "$one"
    else
      die "无法识别包结构（期望顶层 crmeb/）: $root"
    fi
  fi
}

PRESERVE=(
  ".env"
  "public/uploads"
  "runtime"
  "backup"
  ".user.ini"
  "public/.user.ini"
  "public/install.lock"
  # 桌面入口引导页：部分升级包误用 H5 壳覆盖，导致 PC 打开黑屏；保留服务器现网版本
  "public/mobile.html"
)

rsync_overlay() {
  local src="$1"
  local mode_label="$2"
  local excludes=()
  local opts=(-a)
  local p
  for p in "${PRESERVE[@]}"; do
    excludes+=(--exclude="$p")
  done
  excludes+=(
    --exclude='_upgrade_backup'
    --exclude='_upgrade_work'
    --exclude='*.tar.gz'
    --exclude='web-*.zip'
    --exclude='UPGRADE.txt'
  )
  if [[ "$FULL_SYNC" -eq 1 ]]; then
    opts+=(--delete)
    for p in "${PRESERVE[@]}"; do
      opts+=(--filter="P ${p}" --filter="P ${p}/***")
    done
  fi
  log "同步: $src/ -> $LIVE_DIR/  ($mode_label)"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    rsync -a --dry-run --itemize-changes "${opts[@]}" "${excludes[@]}" "$src"/ "$LIVE_DIR"/ | tail -n 40 || true
    log "DRY-RUN: rsync 未写入"
  else
    rsync "${opts[@]}" "${excludes[@]}" "$src"/ "$LIVE_DIR"/
  fi
}

clear_runtime_and_perms() {
  if [[ "$CLEAR_RUNTIME" -eq 1 ]]; then
    if [[ "$DRY_RUN" -eq 0 ]]; then
      mkdir -p "${LIVE_DIR}/runtime"
      find "${LIVE_DIR}/runtime" -mindepth 1 -maxdepth 1 ! -name '.gitignore' -exec rm -rf {} + 2>/dev/null || true
      mkdir -p "${LIVE_DIR}/runtime/"{cache,log,temp,session}
    else
      log "DRY-RUN: clear runtime"
    fi
  fi
  if [[ "$DRY_RUN" -eq 0 ]]; then
    chown -R "$OWNER" "$LIVE_DIR" 2>/dev/null || log "警告: chown 失败"
    chmod -R ug+rwX "${LIVE_DIR}/public/uploads" "${LIVE_DIR}/runtime" 2>/dev/null || true
    # 避免 root 残留日志导致 PHP 写失败
    chown -R "$OWNER" "${LIVE_DIR}/runtime" 2>/dev/null || true
  fi
}

[[ -d "$LIVE_DIR" ]] || die "线上目录不存在: $LIVE_DIR"

# ---------- restore + optional then ----------
if [[ -n "$RESTORE_FROM" ]]; then
  RESTORE_TAR="$(abs_path "$RESTORE_FROM")"
  [[ -f "$RESTORE_TAR" ]] || die "找不到回滚包: $RESTORE_TAR"
  if [[ -n "$THEN_ZIP" ]]; then
    ZIP_ARG="$THEN_ZIP"
  elif [[ -z "$ZIP_ARG" ]]; then
    ZIP_ARG=""
  fi
  ZIP_FILE=""
  if [[ -n "$ZIP_ARG" || -n "$THEN_ZIP" ]]; then
    [[ -n "$THEN_ZIP" ]] && ZIP_ARG="$THEN_ZIP"
    ZIP_FILE="$(resolve_zip)"
  fi

  log "=========================================="
  log "回滚源:   $RESTORE_TAR"
  [[ -n "$ZIP_FILE" ]] && log "再升级:   $ZIP_FILE"
  log "模式:     $([ "$DRY_RUN" -eq 1 ] && echo DRY-RUN || echo APPLY) / $([ "$FULL_SYNC" -eq 1 ] && echo FULL-DELETE || echo INCREMENTAL)"
  log "说明:     保留 .env / uploads；不执行 SQL"
  log "=========================================="

  BACKUP_DIR="${BACKUP_ROOT}/${STAMP}"
  if [[ "$DRY_RUN" -eq 0 ]]; then
    mkdir -p "$BACKUP_DIR"
    if [[ "$SKIP_CODE_BACKUP" -eq 0 ]]; then
      log "[0] 备份当前线上（含错误升级状态）"
      tar -C "$SCRIPT_DIR" \
        --exclude='crmeb/runtime/*' \
        --exclude='crmeb/backup/*' \
        --exclude='crmeb/vendor' \
        --exclude='crmeb/*.tar.gz' \
        --exclude='crmeb/*.zip' \
        -czf "${BACKUP_DIR}/crmeb_code_before_restore.tar.gz" crmeb
      # 双保险保存 .env
      cp -a "${LIVE_DIR}/.env" "${BACKUP_DIR}/env.preserve" 2>/dev/null || true
    fi
  fi

  RESTORE_DIR="${WORK_ROOT}/${STAMP}_restore"
  log "[1] 解压升级前备份"
  rm -rf "$RESTORE_DIR"
  mkdir -p "$RESTORE_DIR"
  if [[ "$DRY_RUN" -eq 0 ]]; then
    tar -xzf "$RESTORE_TAR" -C "$RESTORE_DIR"
  fi
  SRC_RESTORE="$(find_crmeb_src "$RESTORE_DIR")"
  # 强制不要用备份里的 .env 盖线上
  rm -f "${SRC_RESTORE}/.env" 2>/dev/null || true

  # 回滚用 full delete，避免错误包残留文件
  OLD_FULL="$FULL_SYNC"
  FULL_SYNC=1
  rsync_overlay "$SRC_RESTORE" "RESTORE-FULL"
  FULL_SYNC="$OLD_FULL"

  if [[ -n "$ZIP_FILE" ]]; then
    EXTRACT_DIR="${WORK_ROOT}/${STAMP}_zip"
    log "[2] 解压升级包（兼容 Windows 路径）"
    if [[ "$DRY_RUN" -eq 0 ]]; then
      extract_zip_to "$ZIP_FILE" "$EXTRACT_DIR"
    else
      mkdir -p "$EXTRACT_DIR"
      extract_zip_to "$ZIP_FILE" "$EXTRACT_DIR"
    fi
    SRC_DIR="$(find_crmeb_src "$EXTRACT_DIR")"
    log "升级包源码: $SRC_DIR"
    rsync_overlay "$SRC_DIR" "$([ "$FULL_SYNC" -eq 1 ] && echo FULL-DELETE || echo INCREMENTAL)"
    rm -rf "$EXTRACT_DIR"
  else
    log "[2] 未指定升级包，仅完成回滚"
  fi

  log "[3] 清理缓存 / 权限"
  clear_runtime_and_perms

  # 确保 .env 仍在
  if [[ "$DRY_RUN" -eq 0 ]]; then
    if [[ ! -s "${LIVE_DIR}/.env" && -f "${BACKUP_DIR}/env.preserve" ]]; then
      cp -a "${BACKUP_DIR}/env.preserve" "${LIVE_DIR}/.env"
      chown "$OWNER" "${LIVE_DIR}/.env" || true
      log "已从 preserve 恢复 .env"
    fi
    [[ -s "${LIVE_DIR}/.env" ]] || die ".env 丢失"
  fi

  rm -rf "$RESTORE_DIR"
  log "=========================================="
  log "完成：回滚$([ -n "$ZIP_FILE" ] && echo '+重新升级' || echo '')（未执行 SQL）"
  log "备份: ${BACKUP_DIR:-"(无)"}"
  tr '\r' '\n' < "${LIVE_DIR}/.version" 2>/dev/null | sed '/^$/d;s/^/  /' || true
  log "=========================================="
  exit 0
fi

# ---------- 普通升级 ----------
ZIP_FILE="$(resolve_zip)"
SYNC_MODE="INCREMENTAL"
[[ "$FULL_SYNC" -eq 1 ]] && SYNC_MODE="FULL-DELETE"

log "=========================================="
log "目录:     $SCRIPT_DIR"
log "线上:     $LIVE_DIR"
log "升级包:   $ZIP_FILE ($(du -h "$ZIP_FILE" | awk '{print $1}'))"
log "模式:     $([ "$DRY_RUN" -eq 1 ] && echo DRY-RUN || echo APPLY) / $SYNC_MODE"
log "属主:     $OWNER"
log "说明:     仅同步代码，不执行 SQL"
log "=========================================="

BACKUP_DIR="${BACKUP_ROOT}/${STAMP}"
if [[ "$DRY_RUN" -eq 0 ]]; then
  mkdir -p "$BACKUP_DIR"
fi

log "[1/4] 备份线上代码"
if [[ "$SKIP_CODE_BACKUP" -eq 0 ]]; then
  if [[ "$DRY_RUN" -eq 0 ]]; then
    tar -C "$SCRIPT_DIR" \
      --exclude='crmeb/runtime/*' \
      --exclude='crmeb/backup/*' \
      --exclude='crmeb/vendor' \
      --exclude='crmeb/*.tar.gz' \
      --exclude='crmeb/*.zip' \
      -czf "${BACKUP_DIR}/crmeb_code.tar.gz" crmeb
    log "备份: ${BACKUP_DIR}/crmeb_code.tar.gz"
  else
    log "DRY-RUN: tar backup crmeb"
  fi
else
  log "跳过代码备份"
fi

EXTRACT_DIR="${WORK_ROOT}/${STAMP}"
log "[2/4] 解压升级包（兼容 Windows 路径）"
extract_zip_to "$ZIP_FILE" "$EXTRACT_DIR"
SRC_DIR="$(find_crmeb_src "$EXTRACT_DIR")"
log "源码目录: $SRC_DIR"

log "[3/4] 同步代码"
rsync_overlay "$SRC_DIR" "$SYNC_MODE"

if [[ "$DRY_RUN" -eq 0 && ! -s "${LIVE_DIR}/.env" ]]; then
  die ".env 丢失或为空，请从 ${BACKUP_DIR}/crmeb_code.tar.gz 恢复后重试"
fi

log "[4/4] 清理缓存 / 权限"
clear_runtime_and_perms
rm -rf "$EXTRACT_DIR"

log "=========================================="
log "代码升级完成（未执行任何 SQL）"
log "备份目录: ${BACKUP_DIR:-"(无)"}"
if [[ -f "${LIVE_DIR}/.version" ]]; then
  log "当前 .version:"
  tr '\r' '\n' < "${LIVE_DIR}/.version" | sed '/^$/d;s/^/  /' || true
fi
log "=========================================="
