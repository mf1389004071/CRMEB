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
