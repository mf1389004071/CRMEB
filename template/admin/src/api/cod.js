// 菜集鲜：到付订单接口
import request from '@/libs/request';

export function codList(params) {
  return request({ url: 'order/cod/list', method: 'get', params });
}

export function codConfirm(id) {
  return request({ url: `order/cod/confirm/${id}`, method: 'post' });
}

export function codDelivering(id, data) {
  return request({ url: `order/cod/delivering/${id}`, method: 'post', data });
}

export function codDelivered(id) {
  return request({ url: `order/cod/delivered/${id}`, method: 'post' });
}

export function codVerify(data) {
  return request({ url: 'order/cod/verify', method: 'post', data });
}

export function codCollect(id, data) {
  return request({ url: `order/cod/collect/${id}`, method: 'post', data });
}

export function codCancel(id, data) {
  return request({ url: `order/cod/cancel/${id}`, method: 'post', data });
}

export function codCallMark(id, data) {
  return request({ url: `order/cod/call_mark/${id}`, method: 'post', data });
}

export function codAudit(id) {
  return request({ url: `order/cod/audit/${id}`, method: 'get' });
}

export function codNew(params) {
  return request({ url: 'order/cod/new', method: 'get', params });
}

export function codPrintData(params) {
  return request({ url: 'order/cod/print_data', method: 'get', params });
}

export function codPickSummary(params) {
  return request({ url: 'order/cod/pick_summary', method: 'get', params });
}

export function codExportUrl(params) {
  return request({ url: 'order/cod/export', method: 'get', params });
}

export function orderBlacklistList(params) {
  return request({ url: 'order/blacklist', method: 'get', params });
}

export function orderBlacklistAdd(data) {
  return request({ url: 'order/blacklist', method: 'post', data });
}

export function orderBlacklistDel(id) {
  return request({ url: `order/blacklist/${id}`, method: 'delete' });
}
