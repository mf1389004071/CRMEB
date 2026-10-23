// 菜集鲜：商品区域价接口
import request from '@/libs/request';

export function regionPriceGet(productId) {
  return request({ url: `product/region_price/${productId}`, method: 'get' });
}

export function regionPriceSave(productId, data) {
  return request({ url: `product/region_price/${productId}`, method: 'post', data });
}

export function regionPriceTemplate() {
  return request({ url: 'product/region_price/template', method: 'get' });
}

export function regionPriceExport(params) {
  return request({ url: 'product/region_price/export', method: 'get', params });
}

export function regionPriceImport(formData) {
  return request({ url: 'product/region_price/import', method: 'post', data: formData, headers: { 'Content-Type': 'multipart/form-data' } });
}
