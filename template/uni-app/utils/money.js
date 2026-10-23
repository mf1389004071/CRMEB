import Vue from 'vue';
import Cache from '@/utils/cache';

// VN: 币种展示层（M6-4）。价格/订单/应付一律本位币；这里只在展示层换算。
// 规则：行价仅展示换算；合计 = 本位币合计再换算（调用方传入本位币合计即可，不要自行累加已换算的行价）；
//      非本位币金额前缀 ≈，本位币不加。不要在页面里手写千分位或货币符号，统一用 $money()/<BaseMoney>。
const state = Vue.observable({
	base: 'VND',
	display: 'VND',
	list: []
});

const CFG_KEY = 'CURRENCY_CFG';
const DISPLAY_KEY = 'display_currency';

// 兜底配置（接口未返回前使用）：VND 本位，与后台预置一致
const FALLBACK = [{
	code: 'VND',
	symbol: '₫',
	decimal_places: 0,
	thousand_sep: '.',
	decimal_sep: ',',
	rate: '1',
	is_base: 1
}];

function cur(code) {
	const list = state.list.length ? state.list : FALLBACK;
	return list.find((c) => c.code === code) || list.find((c) => Number(c.is_base) === 1) || list[0];
}

export function getCurrencyState() {
	return state;
}

export function currencyList() {
	return state.list.length ? state.list : FALLBACK;
}

// data: {base, default_display, list} 或 basic_config 的 currencies
export function setCurrencyConfig(data, remember) {
	if (!data) return;
	const list = data.list || data.currencies || [];
	if (!list.length) return;
	state.list = list;
	const base = data.base || (list.find((c) => Number(c.is_base) === 1) || list[0]).code;
	state.base = base;
	// 用户显式选择优先；否则取服务端建议的默认展示币种
	const chosen = readChosen();
	state.display = (chosen && list.some((c) => c.code === chosen)) ? chosen : (data.default_display || base);
	if (remember !== false) {
		try {
			uni.setStorageSync(CFG_KEY, {
				base: state.base,
				default_display: data.default_display || base,
				list
			});
		} catch (e) {}
	}
}

function readChosen() {
	try {
		return uni.getStorageSync(DISPLAY_KEY) || '';
	} catch (e) {
		return '';
	}
}

export function setDisplayCurrency(code) {
	state.display = code;
	try {
		uni.setStorageSync(DISPLAY_KEY, code);
	} catch (e) {}
}

export function getDisplayCurrency() {
	return state.display;
}

// 启动时先用本地缓存，避免首屏闪烁
try {
	const cached = uni.getStorageSync(CFG_KEY);
	if (cached && cached.list) setCurrencyConfig(cached, false);
} catch (e) {}

function round(value, dp) {
	const f = Math.pow(10, dp);
	// 加 epsilon 抵消浮点误差，半数进位
	return Math.round((Math.abs(value) + 1e-9) * f) / f * (value < 0 ? -1 : 1);
}

// 本位币金额 → 展示币金额（数值）
export function convertAmount(baseAmount, code) {
	const c = cur(code || state.display);
	const n = Number(baseAmount);
	if (isNaN(n)) return NaN;
	if (Number(c.is_base) === 1) return round(n, c.decimal_places);
	return round(n * Number(c.rate), c.decimal_places);
}

// 拆分展示：{symbol, integer, decimal, approx, text}
export function moneyParts(baseAmount, opts) {
	opts = opts || {};
	const code = opts.code || state.display;
	const c = cur(code);
	let n = Number(baseAmount);
	if (baseAmount === '' || baseAmount === null || baseAmount === undefined || isNaN(n)) {
		return {
			symbol: c.symbol,
			integer: '',
			decimal: '',
			approx: false,
			text: ''
		};
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
		text: sym + (neg ? '-' : '') + integer + (dp > 0 ? c.decimal_sep + decimal : '')
	};
}

// 格式化为字符串：formatMoney(449000) => "₫449.000"；展示币为 USD 时 => "≈$17.96"
export function formatMoney(baseAmount, opts) {
	return moneyParts(baseAmount, opts).text;
}

export default formatMoney;
