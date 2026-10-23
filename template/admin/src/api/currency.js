// 菜集鲜：币种与汇率接口
import request from '@/libs/request';

export function currencyList() {
  return request({ url: 'setting/currency', method: 'get' });
}

export function currencySave(data) {
  return request({ url: 'setting/currency', method: 'post', data });
}

export function currencyDel(id) {
  return request({ url: `setting/currency/${id}`, method: 'delete' });
}

export function currencyLogs(params) {
  return request({ url: 'setting/currency/logs', method: 'get', params });
}
