import request from "@/utils/request.js";

// 菜集鲜（越南站）新增接口，集中放此文件

/** 联系方式列表 */
export function getVnContacts() {
	return request.get("vn/contacts", {}, {
		noAuth: true
	});
}
