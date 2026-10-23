import Vue from 'vue';
import Cache from '@/utils/cache';

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

export const vnMixin = {
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
