/**
 * H5：记录 vue-i18n 缺失的 key（localStorage），并提供导出 SQL 文本（与 Python 脚本逻辑一致）。
 */
const STORAGE_KEY = "I18N_MISSING_KEYS";
const MAX_KEYS = 2000;

function hasChinese(s) {
	return /[\u4e00-\u9fff]/.test(String(s || ""));
}

export function recordMissingI18nKey(key) {
	if (key == null || key === "") return;
	const k = String(key);
	if (!hasChinese(k)) return;
	let arr = [];
	try {
		arr = JSON.parse(uni.getStorageSync(STORAGE_KEY) || "[]");
	} catch (e) {
		arr = [];
	}
	if (!Array.isArray(arr)) arr = [];
	const set = new Set(arr);
	set.add(k);
	const sorted = Array.from(set).sort();
	while (sorted.length > MAX_KEYS) sorted.shift();
	try {
		uni.setStorageSync(STORAGE_KEY, JSON.stringify(sorted));
	} catch (e) {}
}

export function getMissingI18nKeys() {
	try {
		const arr = JSON.parse(uni.getStorageSync(STORAGE_KEY) || "[]");
		return Array.isArray(arr) ? arr : [];
	} catch (e) {
		return [];
	}
}

export function clearMissingI18nKeys() {
	try {
		uni.removeStorageSync(STORAGE_KEY);
	} catch (e) {
		uni.setStorageSync(STORAGE_KEY, "[]");
	}
}

function sqlEscape(s) {
	return String(s).replace(/\\/g, "\\\\").replace(/'/g, "''");
}

/**
 * 生成与 scripts/i18n_lang_code_sql.py 一致的幂等 INSERT 文本（不写文件）。
 * @param {string[]} keys
 * @param {{ table?: string, typeId?: number }} opts
 */
export function buildLangCodeInsertSql(keys, opts = {}) {
	const table = opts.table || "eb_lang_code";
	const typeId = opts.typeId != null ? opts.typeId : 1;
	const list = [...new Set((keys || []).filter((k) => k && hasChinese(k)))].sort();
	const lines = [
		`-- 由 H5 缺失收集工具生成（utils/i18nMissingStorage.js）`,
		`-- 目标表: \`${table}\`  type_id=${typeId}  is_admin=0`,
		"START TRANSACTION;",
		"",
	];
	for (const k of list) {
		const esc = sqlEscape(k);
		lines.push(
			`INSERT INTO \`${table}\` (\`type_id\`, \`code\`, \`remarks\`, \`lang_explain\`, \`is_admin\`)\n` +
				`SELECT ${typeId}, '${esc}', '${esc}', '${esc}', 0\n` +
				`FROM DUAL\n` +
				`WHERE NOT EXISTS (SELECT 1 FROM \`${table}\` WHERE \`type_id\` = ${typeId} AND \`code\` = '${esc}' AND \`is_admin\` = 0);\n`
		);
	}
	lines.push("", "COMMIT;", "");
	return lines.join("\n");
}

export function getMissingKeysPlainText() {
	return getMissingI18nKeys().join("\n");
}
