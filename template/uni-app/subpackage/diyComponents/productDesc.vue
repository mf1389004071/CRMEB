<template>
  <view class="product-intro" v-if="productData.description">
    <common-wrapper :config="dataConfig">
      <view class="title" v-if="titleShow" :style="[titleStyle]">{{
        $t(`产品介绍`)
      }}</view>
      <view class="conter">
        <!-- #ifndef APP-PLUS -->
        <parser
          :html="productData.description"
          ref="article"
          :tag-style="tagStyle"
        ></parser>
        <!-- #endif -->
        <!-- #ifdef APP-PLUS -->
        <view class="description" v-html="productData.description"></view>
        <!-- #endif -->
      </view>
    </common-wrapper>
  </view>
</template>

<script>
import commonWrapper from "./commonWrapper.vue";
import parser from "@/components/jyf-parser/jyf-parser";

export default {
  name: "productDesc",
  components: {
    parser,
    commonWrapper
  },
  props: {
    productData: {
      type: Object,
      default: () => ({}),
    },
    dataConfig: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    titleShow() {
      const show = this.dataConfig && this.dataConfig.isShow;
      return show && show.tabVal == 0;
    },
    titleStyle() {
      const dc = this.dataConfig || {};
      const colorArr = dc.textColor && dc.textColor.color;
      const colorItem = colorArr && colorArr[0] && colorArr[0].item;
      return {
        color: colorItem || "#333",
        fontSize: ((dc.fontSize && dc.fontSize.val) || 16) * 2 + "rpx",
        textAlign: (dc.textPosition && dc.textPosition.val) || "left",
      };
    },
  },
  data() {
    return {
      tagStyle: {
        img: "width:100%;display:block;",
        table: "width:100%",
        video: "width:100%",
      },
    };
  },
};
</script>

<style lang="scss" scoped>
.product-intro {
  .title {
    height: 90rpx;
    line-height: 90rpx;
    font-size: 30rpx;
    color: #282828;
    text-align: center;
  }

  .conter {
    font-size: 30rpx;
    color: #333;
    line-height: 50rpx;
  }
}
</style>
