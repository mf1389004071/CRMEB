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
