// +---------------------------------------------------------------------
// | CRMEB [ CRMEB赋能开发者，助力企业发展 ]
// +---------------------------------------------------------------------
// | Copyright (c) 2016~2023 https://www.crmeb.com All rights reserved.
// +---------------------------------------------------------------------
// | Licensed CRMEB并不是自由软件，未经许可不能去掉CRMEB相关版权
// +---------------------------------------------------------------------
// | Author: CRMEB Team <admin@crmeb.com>
// +---------------------------------------------------------------------

import axios from 'axios';
import { Message } from 'element-ui';
import { getCookies, removeCookies } from '@/libs/util';
import { Local } from '@/utils/storage';
import Setting from '@/setting';
import router from '@/router';
import { resolveAdminLocale } from '@/utils/lang.js';

/** 管理端界面语直接作为 Cb-lang（与移动端/后端 zh-CN|vi-VN|en-US 一致） */
function resolveAdminCbLang() {
  try {
    return resolveAdminLocale((Local.get('themeConfigPrev') || {}).globalI18n);
  } catch (e) {
    return 'zh-CN';
  }
}

const service = axios.create({
  baseURL: Setting.apiBaseURL,
  timeout: 100000, // 请求超时时间
});

axios.defaults.withCredentials = true; // 携带cookie

// 请求拦截器
service.interceptors.request.use(
  (config) => {
    if (config.kefu) {
      let baseUrl = Setting.apiBaseURL.replace(/adminapi/, 'kefuapi');
      config.baseURL = baseUrl;
    } else {
      config.baseURL = Setting.apiBaseURL;
    }
    if (config.file) {
      config.headers['Content-Type'] = 'multipart/form-data';
    }
    const token = getCookies('token');
    const kefuToken = getCookies('kefu_token');
    if (token || kefuToken) {
      config.headers['Authori-zation'] = config.kefu ? 'Bearer ' + kefuToken : 'Bearer ' + token;
    }
    // 与界面语言对齐，避免无头时后端回落站点默认语 vi-VN
    config.headers['Cb-lang'] = resolveAdminCbLang();
    return config;
  },
  (error) => {
    // do something with request error
    return Promise.reject(error);
  },
);

// response interceptor
service.interceptors.response.use(
  (response) => {
    let obj = {};
    if (!!response.data) {
      if (typeof response.data == 'string') {
        obj = JSON.parse(response.data);
      } else {
        obj = response.data;
      }
    }
    let status = response.data ? obj.status : 0;
    // let status = response.data ? response.data.status : 0;
    const code = status;
    switch (code) {
      case 200:
        return obj;
      case 401:
        localStorage.clear();
        removeCookies('token');
        removeCookies('expires_time');
        removeCookies('uuid');
        router.replace({ name: 'login' }).catch(() => {});
        return Promise.reject({ msg: '未登录' });
      case 402:
        removeCookies('kefuInfo');
        removeCookies('kefu_token');
        removeCookies('kefu_expires_time');
        removeCookies('kefu_uuid');
        router.replace({ path: '/kefu' }).catch(() => {});
        return Promise.reject({ msg: '未登录' });
      case 403:
        router.replace({ name: 'system_opendir_login' }).catch(() => {});
        return Promise.reject({ msg: '没有权限' });
      default:
        return Promise.reject(obj || { msg: '未知错误' });
    }
  },
  (error) => {
    Message.error(error.msg);
    return Promise.reject(error);
  },
);

export default service;
