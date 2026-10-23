// 运行：node template/uni-app/tests/money_test.js
// 对 utils/money.js 做无框架测试：抽取源码，stub 掉 vue/uni 后执行
const fs = require('fs');
const path = require('path');
let src = fs.readFileSync(path.join(__dirname, '../utils/money.js'), 'utf8');
src = src
  .replace(/import Vue from 'vue';/, 'const Vue = { observable: (o) => o };')
  .replace(/import Cache from '@\/utils\/cache';/, '')
  .replace(/export default formatMoney;/, '')
  .replace(/export function /g, 'function ');
const store = {};
const uni = { getStorageSync: (k) => store[k] || '', setStorageSync: (k, v) => (store[k] = v) };
const api = new Function('uni', src + '\nreturn { setCurrencyConfig, setDisplayCurrency, formatMoney, moneyParts, convertAmount, getDisplayCurrency };')(uni);
let fail = 0, pass = 0;
const eq = (a, b, name) => { if (a === b) pass++; else { fail++; console.log('FAIL', name, '=>', JSON.stringify(a), 'expected', JSON.stringify(b)); } };

// 兜底配置：VND 本位
eq(api.formatMoney(449000), '₫449.000', 'fallback VND format');
api.setCurrencyConfig({
  base: 'VND', default_display: 'VND',
  list: [
    { code: 'VND', symbol: '₫', decimal_places: 0, thousand_sep: '.', decimal_sep: ',', rate: '1', is_base: 1 },
    { code: 'CNY', symbol: '¥', decimal_places: 2, thousand_sep: ',', decimal_sep: '.', rate: '0.00028', is_base: 0 },
    { code: 'USD', symbol: '$', decimal_places: 2, thousand_sep: ',', decimal_sep: '.', rate: '0.00004', is_base: 0 },
  ],
}, false);
eq(api.formatMoney(449000), '₫449.000', 'VND display');
eq(api.formatMoney('1234567.5'), '₫1.234.568', 'VND rounds half up, thousands dot');
eq(api.formatMoney(0), '₫0', 'zero');
eq(api.formatMoney('-12500'), '₫-12.500', 'negative');
eq(api.formatMoney(''), '', 'empty => empty');
eq(api.formatMoney(undefined), '', 'undefined => empty');
eq(api.formatMoney('abc'), '', 'non numeric => empty');
eq(api.formatMoney(449000, { symbol: false }), '449.000', 'no symbol');

api.setDisplayCurrency('USD');
eq(api.getDisplayCurrency(), 'USD', 'display switched');
eq(api.formatMoney(449000), '≈$17.96', 'M6-5 449000 VND -> ≈$17.96');
eq(api.formatMoney(12500), '≈$0.50', 'USD small');
eq(api.formatMoney(449000, { convert: false }), '$449,000.00', 'convert:false keeps number, uses display format');
eq(api.formatMoney(100000000), '≈$4,000.00', 'USD thousands comma');
api.setDisplayCurrency('CNY');
eq(api.formatMoney(449000), '≈¥125.72', 'CNY');
const parts = api.moneyParts(449000);
eq(parts.integer + '|' + parts.decimal + '|' + parts.decSep + '|' + parts.approx, '125|72|.|true', 'moneyParts split');
api.setDisplayCurrency('VND');
const p2 = api.moneyParts(449000);
eq(p2.integer + '|' + p2.decimal + '|' + p2.approx, '449.000||false', 'VND parts: no decimals, no approx');

// 合计 = 本位币合计再换算
api.setDisplayCurrency('USD');
const lines = [1000, 1000, 1000];
const total = lines.reduce((a, b) => a + b, 0);
eq(api.formatMoney(total), '≈$0.12', 'total converted once from base total');

// 用户选择优先于服务端默认
api.setDisplayCurrency('CNY');
api.setCurrencyConfig({ base: 'VND', default_display: 'USD', list: [
  { code: 'VND', symbol: '₫', decimal_places: 0, thousand_sep: '.', decimal_sep: ',', rate: '1', is_base: 1 },
  { code: 'USD', symbol: '$', decimal_places: 2, thousand_sep: ',', decimal_sep: '.', rate: '0.00004', is_base: 0 }] }, false);
eq(api.getDisplayCurrency(), 'USD', 'chosen CNY no longer available => fall back to server default');
api.setDisplayCurrency('VND');
api.setCurrencyConfig({ base: 'VND', default_display: 'USD', list: [
  { code: 'VND', symbol: '₫', decimal_places: 0, thousand_sep: '.', decimal_sep: ',', rate: '1', is_base: 1 },
  { code: 'USD', symbol: '$', decimal_places: 2, thousand_sep: ',', decimal_sep: '.', rate: '0.00004', is_base: 0 }] }, false);
eq(api.getDisplayCurrency(), 'VND', 'explicit user choice wins over server default');

console.log(fail ? `FAILED ${fail} (passed ${pass})` : `OK ${pass} assertions`);
process.exit(fail ? 1 : 0);
