<template>
  <view
    class="lang-switcher"
    :class="{ compact: compact, 'icon-only': iconOnly }"
    @click.stop
  >
    <picker
      :range="options"
      range-key="name"
      :value="index"
      @change="onChange"
    >
      <view class="trigger" :class="{ 'trigger-icon': iconOnly }">
        <!-- iconfont 无 earth 字形；顶栏纯图标用 emoji，与 RegionBar ☎ 风格一致 -->
        <text class="emoji-lang" v-if="iconOnly">🌐</text>
        <text class="iconfont icon-ic_earth" v-else-if="showIcon"></text>
        <text class="label" v-if="!iconOnly">{{ currentName }}</text>
        <text class="iconfont icon-xiangyou arrow" v-if="!iconOnly"></text>
      </view>
    </picker>
  </view>
</template>

<script>
import Cache from "@/utils/cache";
import i18n, { normalizeLang } from "@/utils/lang.js";
import { getLangList, getLangJson } from "@/api/user.js";
import { setUserLocale } from "@/api/vn.js";
import { mapGetters } from "vuex";

/**
 * VN: 未登录也可切换语言（本地 locale + 拉语言包）；登录后顺带回写服务端。
 */
export default {
  name: "LangSwitcher",
  props: {
    compact: { type: Boolean, default: false },
    showIcon: { type: Boolean, default: true },
    /** 首页顶栏等场景：仅地球图标，点击仍弹出语言 picker */
    iconOnly: { type: Boolean, default: false },
  },
  computed: {
    ...mapGetters(["isLogin"]),
    currentName() {
      const cur = this.options[this.index];
      return cur ? cur.name : this.$t("语言");
    },
  },
  data() {
    return {
      options: [],
      index: 0,
    };
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      getLangList()
        .then((res) => {
          this.options = (res.data || []).filter(
            (i) =>
              ["zh-CN", "vi-VN", "en-US"].indexOf(normalizeLang(i.value)) > -1
          );
          const locale = normalizeLang(
            Cache.get("locale") || this.$i18n.locale || "vi-VN"
          );
          const i = this.options.findIndex(
            (o) => normalizeLang(o.value) === locale
          );
          this.index = i > -1 ? i : 0;
        })
        .catch(() => {});
    },
    onChange(e) {
      const i = Number(e.detail.value);
      const opt = this.options[i];
      if (!opt) return;
      this.index = i;
      const code = normalizeLang(opt.value);
      Cache.set("locale", code);
      getLangJson()
        .then((res) => {
          const pack = res.data || {};
          const key = Object.keys(pack)[0] || code;
          uni.setStorageSync("localeJson", pack);
          if (pack[key]) {
            this.$i18n.setLocaleMessage(key, pack[key]);
          }
          this.$i18n.locale = key;
          uni.removeStorageSync("LANG_VERSION");
          if (this.isLogin) {
            setUserLocale(code).catch(() => {});
          }
          // #ifdef H5
          window.location.reload();
          // #endif
          // #ifndef H5
          uni.reLaunch({ url: "/pages/index/index" });
          // #endif
        })
        .catch(() => {});
    },
  },
};
</script>

<style scoped lang="scss">
.lang-switcher {
  .trigger {
    display: flex;
    align-items: center;
    gap: 8rpx;
    font-size: 26rpx;
    color: #333;
    padding: 8rpx 16rpx;
    background: rgba(255, 255, 255, 0.92);
    border-radius: 28rpx;
  }
  .arrow {
    font-size: 22rpx;
    color: #999;
    transform: rotate(90deg);
  }
  &.compact .trigger {
    padding: 4rpx 12rpx;
    font-size: 24rpx;
  }
  &.icon-only .trigger-icon {
    padding: 0 8rpx;
    background: transparent;
    gap: 0;
    .emoji-lang {
      font-size: 40rpx;
      line-height: 1;
    }
  }
}
</style>
