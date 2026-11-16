// +----------------------------------------------------------------------
// | CRMEB [ CRMEB赋能开发者，助力企业发展 ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2023 https://www.kizerp.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed CRMEB并不是自由软件，未经许可不能去掉CRMEB相关版权
// +----------------------------------------------------------------------
// | Author: CRMEB Team <admin@kizerp.com>
// +----------------------------------------------------------------------
export default {
  namespaced: true,
  state: {
    toggleStatus: false,
  },
  mutations: {
    TOGGLE_STATUS: (state, toggleStatus) => {
      state.toggleStatus = toggleStatus;
    },
  },
  getters: {
    toggleStatus: (state) => state.toggleStatus,
  },
};
