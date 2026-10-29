import request from "@/utils/request.js";

// 菜集鲜（越南站）新增接口，集中放此文件

/** 联系方式列表 */
export function getVnContacts() {
	return request.get("vn/contacts", {}, {
		noAuth: true
	});
}

/** 员工端：到付订单核销前查询（code 或 order_id） */
export function codVerifyDetail(data) {
	return request.get("admin/order/cod/detail", data);
}

/** 员工端：到付订单送达核销 */
export function codVerify(data) {
	return request.post("admin/order/cod/verify", data);
}

/** 配送区域：子节点（parent_id=0 为国家层） */
export function regionChildren(data) {
	return request.get("region/children", data, {
		noAuth: true
	});
}

/** 配送区域：热门城市 */
export function regionHot() {
	return request.get("region/hot", {}, {
		noAuth: true
	});
}

/** 配送区域：经纬度定位 */
export function regionLocate(data) {
	return request.post("region/locate", data, {
		noAuth: true
	});
}

/** 配送区域：校验并返回完整链 */
export function regionInfo(data) {
	return request.get("region/info", data, {
		noAuth: true
	});
}

/** 切换区域时清空购物车 */
export function clearCartAll() {
	return request.post("cart/clear_all", {});
}

/** 地址选择用：所有 is_show 子节点（不受配送白名单限制），parent_id=0 为国家层 */
export function regionAddressChildren(data) {
	return request.get("region/address_children", data, {
		noAuth: true
	});
}

/** 手机区号字典 */
export function phoneCountries() {
	return request.get("phone/countries", {}, {
		noAuth: true
	});
}

/** 按地址 city_id 匹配提货仓 */
export function warehouseMatch(data) {
	return request.get("warehouse/match", data, {
		noAuth: true
	});
}

/** 保存用户语种（登录后同步到服务端） */
export function setUserLocale(locale) {
	return request.post("user/locale", {
		locale
	});
}

/** 币种与汇率（含本次请求默认展示币种） */
export function getCurrencyConfig() {
	return request.get("public/currency", {}, {
		noAuth: true
	});
}

/** 保存用户展示币种 */
export function setUserCurrency(currency) {
	return request.post("user/currency", {
		currency
	});
}
