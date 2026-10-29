/*
 * @Author: From-wh from-wh@hotmail.com
 * @Date: 2023-03-09 18:02:23
 * @FilePath: /admin/src/i18n/index.js
 * @Description:
 */
import Vue from 'vue';
import VueI18n from 'vue-i18n';
import zhcnLocale from 'element-ui/lib/locale/lang/zh-CN';
import enLocale from 'element-ui/lib/locale/lang/en';
import store from '@/store/index.js';
import { resolveAdminLocale } from '@/utils/lang.js';

import nextZhcn from '@/i18n/lang/zh-cn.js';
import nextEn from '@/i18n/lang/en.js';
import nextViVn from '@/i18n/lang/vi-vn.js';

import pagesHomeZhcn from '@/i18n/pages/home/zh-cn.js';
import pagesHomeEn from '@/i18n/pages/home/en.js';
import pagesLoginZhcn from '@/i18n/pages/login/zh-cn.js';
import pagesLoginEn from '@/i18n/pages/login/en.js';
// 使用插件
Vue.use(VueI18n);

// 定义语言国际化内容
/**
 * 说明：
 * locale key 与移动端/后端一致：zh-CN / vi-VN / en-US
 * /src/i18n/lang 下的 js 为框架的国际化内容
 * /src/i18n/pages 下的 js 为各界面的国际化内容
 * 越南语暂无独立 login/home 页包，回落英文页包；Element 组件文案暂用英文包
 */
const messages = {
  'zh-CN': {
    ...zhcnLocale,
    message: {
      ...nextZhcn,
      ...pagesHomeZhcn,
      ...pagesLoginZhcn,
    },
  },
  'en-US': {
    ...enLocale,
    message: {
      ...nextEn,
      ...pagesHomeEn,
      ...pagesLoginEn,
    },
  },
  'vi-VN': {
    ...enLocale,
    message: {
      ...nextViVn,
      ...pagesHomeEn,
      ...pagesLoginEn,
    },
  },
};

const locale = resolveAdminLocale(store.state.themeConfig.themeConfig.globalI18n);
store.state.themeConfig.themeConfig.globalI18n = locale;

// 导出语言国际化
export const i18n = new VueI18n({
  locale,
  fallbackLocale: 'zh-CN',
  messages,
  silentTranslationWarn: true, // 去除国际化警告
});
