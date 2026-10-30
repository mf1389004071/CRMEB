/**
 * 管理端金额展示（与移动端 utils/money.js / 后端 MoneyServices 规则对齐）
 * - 价格/订单/应付一律本位币存储；本工具只做展示层格式化/换算
 * - 管理端默认展示本位币；可用 opts.code 指定展示币
 * - 非本位币前缀 ≈；统一用 this.$money() 或 money 过滤器
 * 注意：禁止顶层 import @/api/*（会经 request→router 与 main 形成环，导致白屏）
 */
import Vue from 'vue';

const state = Vue.observable({
  base: 'VND',
  display: 'VND',
  list: [],
});

const CFG_KEY = 'ADMIN_CURRENCY_CFG_v2';

const FALLBACK = [
  {
    code: 'VND',
    symbol: '₫',
    decimal_places: 0,
    thousand_sep: ',',
    decimal_sep: '.',
    rate: '1',
    is_base: 1,
  },
];

function cur(code) {
  const list = state.list.length ? state.list : FALLBACK;
  return list.find((c) => c.code === code) || list.find((c) => Number(c.is_base) === 1) || list[0];
}

function readCache() {
  try {
    const raw = localStorage.getItem(CFG_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch (e) {
    return null;
  }
}

function writeCache(payload) {
  try {
    localStorage.setItem(CFG_KEY, JSON.stringify(payload));
  } catch (e) {}
}

export function getCurrencyState() {
  return state;
}

export function currencyList() {
  return state.list.length ? state.list : FALLBACK;
}

/** data: { base, default_display, list } 或直接传币种行数组 */
export function setCurrencyConfig(data, remember) {
  if (!data) return;
  const list = Array.isArray(data) ? data : data.list || data.currencies || [];
  if (!list.length) return;
  state.list = list;
  const base =
    (Array.isArray(data) ? null : data.base) ||
    (list.find((c) => Number(c.is_base) === 1) || list[0]).code;
  state.base = base;
  const def = (!Array.isArray(data) && data.default_display) || base;
  state.display = list.some((c) => c.code === def) ? def : base;
  if (remember !== false) {
    writeCache({ base: state.base, default_display: state.display, list });
  }
}

export function setDisplayCurrency(code) {
  if (!code) return;
  state.display = code;
}

export function getDisplayCurrency() {
  return state.display;
}

export function getBaseCurrency() {
  return state.base;
}

try {
  const cached = readCache();
  if (cached && cached.list) setCurrencyConfig(cached, false);
} catch (e) {}

function round(value, dp) {
  const f = Math.pow(10, dp);
  return (Math.round((Math.abs(value) + 1e-9) * f) / f) * (value < 0 ? -1 : 1);
}

export function convertAmount(baseAmount, code) {
  const c = cur(code || state.display);
  const n = Number(baseAmount);
  if (isNaN(n)) return NaN;
  if (Number(c.is_base) === 1) return round(n, c.decimal_places);
  return round(n * Number(c.rate), c.decimal_places);
}

export function moneyParts(baseAmount, opts) {
  opts = opts || {};
  const code = opts.code || state.display;
  const c = cur(code);
  const n = Number(baseAmount);
  if (baseAmount === '' || baseAmount === null || baseAmount === undefined || isNaN(n)) {
    return { symbol: c.symbol, integer: '', decimal: '', approx: false, decSep: c.decimal_sep, text: '' };
  }
  const v = opts.convert === false ? round(n, c.decimal_places) : convertAmount(n, code);
  const neg = v < 0;
  const abs = Math.abs(v);
  const dp = Number(c.decimal_places);
  const fixed = abs.toFixed(dp);
  const parts = fixed.split('.');
  const integer = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, c.thousand_sep);
  const decimal = dp > 0 ? parts[1] : '';
  const approx = opts.convert !== false && Number(c.is_base) !== 1;
  const sym = opts.symbol === false ? '' : (approx ? '≈' : '') + c.symbol;
  return {
    symbol: sym,
    integer: (neg ? '-' : '') + integer,
    decimal,
    approx,
    decSep: c.decimal_sep,
    text: sym + (neg ? '-' : '') + integer + (dp > 0 ? c.decimal_sep + decimal : ''),
  };
}

/** formatMoney(449000) => "₫449,000" */
export function formatMoney(baseAmount, opts) {
  return moneyParts(baseAmount, opts).text;
}

/** 输入框展示用：千分位、无符号；按本位币小数位（VND=0） */
export function formatMoneyInput(amount, opts) {
  opts = opts || {};
  return moneyParts(amount, {
    code: opts.code || state.base,
    convert: false,
    symbol: false,
  }).text;
}

/**
 * 解析输入：去掉千分位/符号/空格，得到可提交的数字字符串；空 → ''
 */
export function parseMoneyInput(val) {
  if (val === '' || val === null || val === undefined) return '';
  let s = String(val)
    .replace(/[₫¥$≈\s]/g, '')
    .replace(/,/g, '');
  // 若误用欧式小数逗号且无点，保留最后一个逗号为小数点
  if (s.indexOf('.') < 0 && (s.match(/,/g) || []).length === 1) {
    s = s.replace(',', '.');
  }
  if (s === '' || s === '-' || s === '.') return '';
  const n = Number(s);
  if (isNaN(n)) return '';
  return String(n);
}

export function baseCurrencySymbol() {
  const c = cur(state.base);
  return (c && c.symbol) || '₫';
}

export function baseDecimalPlaces() {
  const c = cur(state.base);
  return c ? Number(c.decimal_places) : 0;
}

/** 启动/登录后拉取后台币种表（动态 import，避免与 main/router 循环依赖） */
export function loadCurrencyConfig() {
  return import('@/api/currency')
    .then((m) => m.currencyList())
    .then((res) => {
      const rows = (res && res.data) || [];
      if (rows.length) setCurrencyConfig(rows, true);
      return currencyList();
    })
    .catch(() => currencyList());
}

export default formatMoney;
