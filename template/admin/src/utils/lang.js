/**
 * 与移动端 template/uni-app/utils/lang.js、后端 normalize_lang_code 对齐：
 * 统一为 zh-CN / vi-VN / en-US
 */
export function normalizeLang(code) {
  const key = String(code || '')
    .trim()
    .toLowerCase()
    .replace(/_/g, '-');
  const map = {
    vi: 'vi-VN',
    'vi-vn': 'vi-VN',
    zh: 'zh-CN',
    'zh-cn': 'zh-CN',
    'zh-hans': 'zh-CN',
    'zh-hans-cn': 'zh-CN',
    en: 'en-US',
    'en-us': 'en-US',
    'en-gb': 'en-US',
  };
  return map[key] || String(code || '').trim();
}

/** 管理端可切换语种（与移动端 LangSwitcher 过滤一致） */
export const ADMIN_LANGS = [
  { value: 'zh-CN', label: '简体中文' },
  { value: 'vi-VN', label: 'Tiếng Việt' },
  { value: 'en-US', label: 'English' },
];

const ADMIN_LANG_VALUES = ADMIN_LANGS.map((i) => i.value);

/**
 * 解析为管理端可用 locale；历史 zh-tw / 未知码回落 zh-CN（与旧 request 对 zh-tw 的处理一致）
 */
export function resolveAdminLocale(code) {
  const n = normalizeLang(code);
  if (ADMIN_LANG_VALUES.indexOf(n) > -1) return n;
  const key = String(code || '')
    .trim()
    .toLowerCase()
    .replace(/_/g, '-');
  if (key === 'zh-tw' || key === 'zh-hant') return 'zh-CN';
  return 'zh-CN';
}
