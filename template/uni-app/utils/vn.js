import Vue from 'vue';
import Cache from '@/utils/cache';
import { getRegionId } from '@/utils/region.js';

// VN: 越南站点开关（来自 api/basic_config 的 vn_mode_enable / region_pricing_enable），响应式
const state = Vue.observable({
	vnMode: false,
	regionPricing: false
});

export function setVnConfig(cfg) {
	cfg = cfg || {};
	state.vnMode = cfg.vn_mode_enable === true || cfg.vn_mode_enable === 1;
	state.regionPricing = state.vnMode && (cfg.region_pricing_enable === true || cfg.region_pricing_enable === 1);
}

// 启动时先用本地缓存的配置，避免首屏闪烁
try {
	setVnConfig(Cache.get('BASIC_CONFIG'));
} catch (e) {}

export function isVnMode() {
	return state.vnMode;
}

export function isRegionPricing() {
	return state.regionPricing;
}

// 需要先选择配送区域的页面（登录页、协议页、联系方式页等除外）
const REGION_GUARD_PAGES = [
	'pages/index/index',
	'pages/goods_cate/goods_cate',
	'pages/goods_details/index',
	'pages/order_addcart/order_addcart',
	'pages/goods/goods_list/index',
	'pages/goods/goods_search/index',
	'pages/goods/order_confirm/index'
];

export const vnMixin = {
	onShow() {
		try {
			if (!state.regionPricing) return;
			const stack = getCurrentPages();
			if (!stack || !stack.length) return;
			const route = (stack[stack.length - 1].route || '').replace(/^\//, '');
			if (REGION_GUARD_PAGES.indexOf(route) > -1 && !getRegionId()) {
				uni.navigateTo({
					url: '/pages/region/select'
				});
			}
		} catch (e) {}
	},
	computed: {
		vnMode() {
			return state.vnMode;
		},
		regionPricing() {
			return state.regionPricing;
		}
	}
};

export default state;
