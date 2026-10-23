// 菜集鲜：商品生鲜属性接口
import request from '@/libs/request';

export function freshGet(productId) {
  return request({ url: `product/fresh/${productId}`, method: 'get' });
}

export function freshSave(productId, data) {
  return request({ url: `product/fresh/${productId}`, method: 'post', data });
}
