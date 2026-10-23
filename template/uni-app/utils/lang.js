import Vue from 'vue';
import VueI18n from 'vue-i18n'
import Cache from '@/utils/cache';
// #ifdef H5
import { recordMissingI18nKey } from '@/utils/i18nMissingStorage.js';
// #endif

Vue.use(VueI18n)

let lang = '';
// VN: 语言码统一规范化为 zh-CN / vi-VN / en-US；默认越南语，不再取 navigator.language
export function normalizeLang(code) {
	const key = String(code || '').trim().toLowerCase().replace(/_/g, '-');
	const map = {
		'vi': 'vi-VN', 'vi-vn': 'vi-VN',
		'zh': 'zh-CN', 'zh-cn': 'zh-CN', 'zh-hans': 'zh-CN', 'zh-hans-cn': 'zh-CN',
		'en': 'en-US', 'en-us': 'en-US', 'en-gb': 'en-US'
	};
	return map[key] || String(code || '').trim();
}
lang = normalizeLang(Cache.has('locale') ? Cache.get('locale') : '') || 'vi-VN';
const i18n = new VueI18n({
	locale: lang,
	fallbackLocale: 'vi-VN',
	messages: uni.getStorageSync('localeJson'),
	silentTranslationWarn: true, // 去除国际化警告
	// #ifdef H5
	missing(locale, key) {
		recordMissingI18nKey(key);
		return key;
	},
	// #endif
})
export default i18n

// VN: 语种与服务端同步（M5-1）
// 登录成功后调用：服务端有语种→覆盖本地并要求刷新语言包；服务端为空→把本地语种回写服务端。
// 返回 true 表示本地语种被服务端覆盖（调用方需重新拉取语言包/刷新页面）
export function syncLocaleAfterLogin(serverLocale, saveFn) {
	const local = normalizeLang(Cache.has('locale') ? Cache.get('locale') : '') || 'vi-VN';
	const server = normalizeLang(serverLocale || '');
	if (server) {
		if (server !== local) {
			Cache.set('locale', server);
			try {
				uni.removeStorageSync('localeJson');
				uni.removeStorageSync('LANG_VERSION');
			} catch (e) {}
			return true;
		}
		return false;
	}
	if (typeof saveFn === 'function') {
		saveFn(local);
	}
	return false;
}
