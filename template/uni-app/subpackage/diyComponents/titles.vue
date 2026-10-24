<template>
  <!-- 标题 -->
  <common-wrapper :config="configData" v-show="!isSortType">
    <view :style="[titleWrapStyle]">
      <view
        @click="goLink"
        class="title acea-row row-middle row-between"
        :style="[titleLocation]"
      >
        <view :style="[titleStyle]">{{ dataConfig.titleConfig.value ? $t(dataConfig.titleConfig.value) : "" }}</view>
        <view
          class="more"
          v-if="!dataConfig.buttonConfig.tabVal"
          :style="[moreStyle]"
        >
          {{ dataConfig.titleConfigRight.value ? $t(dataConfig.titleConfigRight.value) : "" }}
          <text class="iconfont icon-ic_rightarrow"></text>
        </view>
      </view>
    </view>
  </common-wrapper>
</template>

<script>
import commonWrapper from "./commonWrapper.vue";
export default {
  components: { commonWrapper },
  name: "titles",
  props: {
    dataConfig: {
      type: Object,
      default: () => {},
    },
    isSortType: {
      type: String | Number,
      default: 0,
    },
  },
  computed: {
    configData() {
      return {
        ...this.dataConfig,
        paddingConfig: this.dataConfig.paddingConfig || {
          isAll: false,
          valList: [
            {
              val: this.dataConfig.topConfig
                ? this.dataConfig.topConfig.val
                : 0,
            },
            {
              val: this.dataConfig.prConfig ? this.dataConfig.prConfig.val : 0,
            },
            {
              val: this.dataConfig.bottomConfig
                ? this.dataConfig.bottomConfig.val
                : 0,
            },
            {
              val: this.dataConfig.prConfig ? this.dataConfig.prConfig.val : 0,
            },
          ],
        },
        marginConfig: this.dataConfig.marginConfig || {
          isAll: false,
          valList: [
            {
              val: this.dataConfig.mbConfig ? this.dataConfig.mbConfig.val : 0,
            },
            {
              val: 0,
            },
            {
              val: 0,
            },
            {
              val: 0,
            },
          ],
        },
      };
    },
    titleWrapStyle() {
      const fillet = this.dataConfig.fillet;
      let borderRadius =
        fillet && fillet.val !== undefined ? `${fillet.val * 2}rpx` : "0rpx";
      if (
        fillet &&
        fillet.type &&
        fillet.valList &&
        fillet.valList.length >= 4
      ) {
        borderRadius = `${fillet.valList[0].val * 2}rpx ${
          fillet.valList[1].val * 2
        }rpx ${fillet.valList[3].val * 2}rpx ${fillet.valList[2].val * 2}rpx`;
      }
      const mc = this.dataConfig.moduleColor;
      let background = "transparent";
      if (mc && mc.color && mc.color[0] && mc.color[1]) {
        background = `linear-gradient(90deg, ${mc.color[0].item} 0%, ${mc.color[1].item} 100%)`;
      }
      return {
        "border-radius": borderRadius,
        background,
      };
    },
    titleStyle() {
      const fs =
        this.dataConfig.fontSize && this.dataConfig.fontSize.val !== undefined
          ? this.dataConfig.fontSize.val
          : 16;
      const tc = this.dataConfig.themeColor;
      let style = {
        "font-size": `${fs * 2}rpx`,
        color:
          tc && tc.color && tc.color[0] ? tc.color[0].item : "#333333",
      };
      const textStyle = this.dataConfig.textStyle;
      if (textStyle) {
        switch (textStyle.tabVal) {
          case 1:
            style["font-style"] = "italic";
            break;
          case 2:
            style["font-weight"] = "bold";
            break;
        }
      }
      return style;
    },
    titleLocation() {
      if (
        this.dataConfig.buttonConfig &&
        this.dataConfig.buttonConfig.tabVal
      ) {
        let style = {};
        const tp = this.dataConfig.textPosition;
        if (tp) {
          switch (tp.tabVal) {
            case 1:
              style["justify-content"] = "center";
              break;
            case 2:
              style["justify-content"] = "flex-end";
              break;
          }
        }
        return style;
      }
    },
    moreStyle() {
      const bt = this.dataConfig.buttonText;
      const bc = this.dataConfig.buttonColor;
      return {
        "font-size": `${((bt && bt.val) || 12) * 2}rpx`,
        color:
          bc && bc.color && bc.color[0] ? bc.color[0].item : "#999999",
      };
    },
  },
  methods: {
    goLink() {
      this.$util.JumpPath(this.dataConfig.linkConfig.value);
    },
  },
};
</script>

<style lang="scss">
.title {
  justify-content: space-between;
  padding: 26rpx 24rpx;
  border-radius: 16rpx 16rpx 0rpx 0rpx;
  font-weight: 500;
  font-size: 32rpx;
  line-height: 44rpx;
  color: #333333;

  .more {
    font-weight: 400;
    font-size: 24rpx;
    line-height: 34rpx;
    color: #999999;
  }

  .iconfont {
    font-size: 24rpx;
  }
}
</style>
