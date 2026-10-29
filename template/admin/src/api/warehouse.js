import request from '@/libs/request';

export function warehouseList(params) {
  return request({ url: 'warehouse/list', method: 'get', params });
}

export function warehouseRead(params) {
  return request({ url: 'warehouse/read', method: 'get', params });
}

export function warehouseSave(data) {
  return request({ url: 'warehouse/save', method: 'post', data });
}

export function warehouseDelete(data) {
  return request({ url: 'warehouse/delete', method: 'post', data });
}

export function warehouseQuickCreate(data) {
  return request({ url: 'warehouse/quick_create', method: 'post', data });
}

export function warehouseSetRegionDefault(data) {
  return request({ url: 'warehouse/set_region_default', method: 'post', data });
}

export function warehouseForRegion(params) {
  return request({ url: 'warehouse/for_region', method: 'get', params });
}

export function warehouseHealth() {
  return request({ url: 'warehouse/health', method: 'get' });
}

export function warehouseOptions() {
  return request({ url: 'warehouse/options', method: 'get' });
}
