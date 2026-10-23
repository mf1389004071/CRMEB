<!--
 * @Author: From-wh from-wh@hotmail.com
 * @Date: 2023-03-09 15:45:51
 * @FilePath: /admin/src/layout/navMenu/subItem.vue
 * @Description:
-->
<template>
  <div>
    <template v-for="val in chil">
      <el-submenu :index="val.path" :key="val.path" v-if="val.is_show && val.children && val.children.length > 0">
        <template slot="title">
          <i class="ivu-icon" :class="'el-icon-' + val.icon"></i>
          <span>{{ $t(val.title) }}</span>
        </template>
        <sub-item :chil="val.children" />
      </el-submenu>
      <template v-else-if="val.is_show">
        <el-menu-item :index="val.path" :key="val.path">
          <template v-if="!val.isLink || (val.isLink && val.isIframe)">
            <i class="ivu-icon" :class="val.icon ? 'el-icon-' + val.icon : ''"></i>
            <span>{{ $t(val.title) }}</span>
            <span class="cod-dot" v-if="val.title === '到付订单' && codPending > 0">{{ codPending > 99 ? '99+' : codPending }}</span>
          </template>
          <template v-else>
            <a :href="val.isLink" target="_blank">
              <i class="ivu-icon" :class="val.icon ? 'el-icon-' + val.icon : ''"></i>
              {{ $t(val.title) }}
            </a>
          </template>
        </el-menu-item>
      </template>
    </template>
  </div>
</template>

<script>
import { mapState } from 'vuex';
export default {
  name: 'subItem',
  computed: {
    ...mapState('cod', { codPending: 'pending' }),
  },
  props: {
    chil: {
      type: Array,
      default() {
        return [];
      },
    },
  },
};
</script>

<style lang="scss" scoped>
.cod-dot {
  display: inline-block;
  min-width: 18px;
  height: 18px;
  line-height: 18px;
  padding: 0 5px;
  margin-left: 6px;
  border-radius: 9px;
  background: #f56c6c;
  color: #fff;
  font-size: 12px;
  text-align: center;
}
</style>
