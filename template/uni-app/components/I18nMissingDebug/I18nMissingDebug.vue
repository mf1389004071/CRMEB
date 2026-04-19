<template>
  <view class="i18n-debug-root">
    <view
      v-if="i18nDebugFab"
      class="i18n-missing-fab"
      @click="openPanel"
    >i18n</view>
    <view
      v-if="panel"
      class="i18n-missing-mask"
      @click.self="closePanel"
    >
      <view class="i18n-missing-dialog" @click.stop>
        <view class="i18n-missing-title">缺失的 i18n key（含中文）</view>
        <view class="i18n-missing-hint">
          开启：URL 加 ?i18n_debug=1 或控制台执行 uni.setStorageSync('I18N_DEBUG_TOOL','1')
        </view>
        <view class="i18n-missing-count">
          共 {{ (plain || '').split(/\n/).filter(Boolean).length }} 条
        </view>
        <textarea
          class="i18n-missing-textarea"
          :value="plain"
          disabled
        />
        <view class="i18n-missing-btns">
          <button size="mini" type="primary" @click="copyPlain">复制 key 列表</button>
          <button size="mini" type="default" @click="copySql">复制 SQL</button>
          <button size="mini" type="warn" @click="clearKeys">清空缓存</button>
          <button size="mini" @click="closePanel">关闭</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import {
  getMissingI18nKeys,
  clearMissingI18nKeys,
  buildLangCodeInsertSql,
} from "@/utils/i18nMissingStorage.js";

export default {
  name: "I18nMissingDebug",
  data() {
    return {
      panel: false,
      plain: "",
      sql: "",
    };
  },
  computed: {
    i18nDebugFab() {
      try {
        return uni.getStorageSync("I18N_DEBUG_TOOL") === "1";
      } catch (e) {
        return false;
      }
    },
  },
  mounted() {
    uni.$on("i18n-missing-debug-refresh", this.onAppShowRefresh);
  },
  beforeDestroy() {
    uni.$off("i18n-missing-debug-refresh", this.onAppShowRefresh);
  },
  methods: {
    onAppShowRefresh() {
      if (this.panel) this.refreshPreview();
    },
    refreshPreview() {
      const keys = getMissingI18nKeys();
      this.plain = keys.join("\n");
      this.sql = buildLangCodeInsertSql(keys);
    },
    openPanel() {
      this.panel = true;
      this.refreshPreview();
    },
    closePanel() {
      this.panel = false;
    },
    copyPlain() {
      uni.setClipboardData({
        data: this.plain || "",
        success: () => {
          uni.showToast({ title: "已复制", icon: "none" });
        },
      });
    },
    copySql() {
      uni.setClipboardData({
        data: this.sql || "",
        success: () => {
          uni.showToast({ title: "已复制 SQL", icon: "none" });
        },
      });
    },
    clearKeys() {
      clearMissingI18nKeys();
      this.refreshPreview();
      uni.showToast({ title: "已清空", icon: "none" });
    },
  },
};
</script>

<style scoped>
.i18n-debug-root {
  position: fixed;
  left: 0;
  top: 0;
  width: 0;
  height: 0;
  overflow: visible;
  pointer-events: none;
  z-index: 999998;
}
.i18n-missing-fab {
  pointer-events: auto;
  position: fixed;
  right: 12px;
  bottom: 120px;
  padding: 8px 10px;
  font-size: 12px;
  color: #fff;
  background: rgba(0, 0, 0, 0.55);
  border-radius: 6px;
  z-index: 999999;
}
.i18n-missing-mask {
  pointer-events: auto;
  position: fixed;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.45);
  z-index: 999999;
  display: flex;
  align-items: center;
  justify-content: center;
}
.i18n-missing-dialog {
  width: 86vw;
  max-width: 520px;
  max-height: 80vh;
  background: #fff;
  border-radius: 10px;
  padding: 14px;
  box-sizing: border-box;
}
.i18n-missing-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 8px;
}
.i18n-missing-hint {
  font-size: 12px;
  color: #666;
  margin-bottom: 6px;
  word-break: break-all;
}
.i18n-missing-count {
  font-size: 12px;
  color: #999;
  margin-bottom: 8px;
}
.i18n-missing-textarea {
  width: 100%;
  height: 160px;
  font-size: 12px;
  border: 1px solid #eee;
  padding: 8px;
  box-sizing: border-box;
  margin-bottom: 10px;
}
.i18n-missing-btns {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}
</style>
