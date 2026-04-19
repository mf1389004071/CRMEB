/**
 * 全局导航栏标题国际化：根据当前页 route 查表并 uni.setNavigationBarTitle。
 * 表由 scripts/gen_navigation_bar_i18n_map.py 从 pages.json 生成，pages.json 保留原标题作说明。
 */
import {
	NAVIGATION_BAR_TITLE_MAP,
	NAVIGATION_BAR_CUSTOM_ROUTES,
} from "@/utils/navigationBarI18nMap.js";

export default {
	onShow() {
		try {
			const stack = getCurrentPages();
			if (!stack || stack.length === 0) return;
			const page = stack[stack.length - 1];
			let route = page.route || page.__route__ || "";
			if (!route) return;
			if (route.charAt(0) === "/") route = route.slice(1);
			if (NAVIGATION_BAR_CUSTOM_ROUTES.has(route)) return;
			const titleKey = NAVIGATION_BAR_TITLE_MAP[route];
			if (!titleKey) return;
			uni.setNavigationBarTitle({
				title: this.$t(titleKey),
			});
		} catch (e) {
			// 无原生导航栏等场景忽略
		}
	},
};
