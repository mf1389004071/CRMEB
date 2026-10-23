// 菜集鲜：到付订单提醒状态（不持久化）
export default {
  namespaced: true,
  state: {
    pending: 0, // 待确认订单数（侧栏红点）
  },
  mutations: {
    setPending(state, n) {
      state.pending = Number(n) || 0;
    },
  },
};
