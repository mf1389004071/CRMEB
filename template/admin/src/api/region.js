// 菜集鲜：配送区域/区划管理接口
import request from '@/libs/request';

export function regionList(params) {
  return request({ url: 'region/list', method: 'get', params });
}

export function regionOpen(data) {
  return request({ url: 'region/open', method: 'post', data });
}

export function regionHot(data) {
  return request({ url: 'region/hot', method: 'post', data });
}

export function regionSort(data) {
  return request({ url: 'region/sort', method: 'post', data });
}

export function regionSave(data) {
  return request({ url: 'region/save', method: 'post', data });
}

export function regionImport(formData) {
  return request({ url: 'region/import', method: 'post', data: formData, headers: { 'Content-Type': 'multipart/form-data' } });
}

export function regionRebuildPath() {
  return request({ url: 'region/rebuild_path', method: 'post' });
}
