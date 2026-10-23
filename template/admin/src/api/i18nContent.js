// 菜集鲜：内容多语接口
import request from '@/libs/request';

export function i18nRead(type, id) {
  return request({ url: `i18n/${type}/${id}`, method: 'get' });
}

export function i18nWrite(type, id, data) {
  return request({ url: `i18n/${type}/${id}`, method: 'post', data });
}

export function i18nMachine(type, id, data) {
  return request({ url: `i18n/${type}/${id}/machine`, method: 'post', data });
}

export function i18nMissing(params) {
  return request({ url: 'i18n/missing', method: 'get', params });
}

export function i18nExport(params) {
  return request({ url: 'i18n/export', method: 'get', params });
}

export function i18nImport(formData) {
  return request({ url: 'i18n/import', method: 'post', data: formData, headers: { 'Content-Type': 'multipart/form-data' } });
}
