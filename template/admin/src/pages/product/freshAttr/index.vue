<template>
  <div>
    <pages-header :title="'生鲜属性：' + (form.store_name || '')" :backUrl="$routeProStr + '/product/product_list'"></pages-header>
    <el-card :bordered="false" shadow="never" class="mt16" v-loading="loading">
      <el-form label-width="130px" style="max-width: 640px">
        <el-form-item label="是否生鲜商品">
          <el-switch v-model="form.is_fresh" :active-value="1" :inactive-value="0" />
          <span class="gray">开启后产地必填；其余项在前台“商品信息”区块展示，空值不显示</span>
        </el-form-item>
        <template v-if="form.is_fresh == 1">
          <el-form-item label="产地*"><el-input v-model="form.origin" maxlength="64" placeholder="默认语言（越南语）填写，其他语言在“多语”中维护" /></el-form-item>
          <el-form-item label="净含量">
            <el-input v-model="form.net_weight" style="width: 160px" placeholder="如 0.5" />
            <span class="gray"> {{ form.unit_name || '单位' }}（>0 时前台显示折算单价）</span>
          </el-form-item>
          <el-form-item label="保质期天数"><el-input-number v-model="form.shelf_life_days" :min="0" /></el-form-item>
          <el-form-item label="保质期文案"><el-input v-model="form.shelf_life_text" maxlength="64" placeholder="如：5 天，0-4°C 保存（留空则显示天数）" /></el-form-item>
          <el-form-item label="需冷链"><el-switch v-model="form.need_cold_chain" :active-value="1" :inactive-value="0" /></el-form-item>
          <el-form-item label="冷链备注" v-if="form.need_cold_chain == 1"><el-input v-model="form.cold_chain_note" maxlength="128" /></el-form-item>
          <el-form-item label="税率(%)"><el-input v-model="form.tax_rate" style="width: 160px" placeholder="仅展示，不做价税分离" /></el-form-item>
        </template>
        <el-form-item>
          <el-button type="primary" @click="save">保存</el-button>
          <el-button @click="$router.push({ path: $routeProStr + '/product/i18n/product/' + productId })">维护多语（产地/冷链/保质期文案）</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { freshGet, freshSave } from '@/api/fresh';

export default {
  name: 'productFreshAttr',
  data() {
    return {
      loading: false,
      form: { store_name: '', unit_name: '', is_fresh: 0, origin: '', net_weight: 0, shelf_life_days: 0, shelf_life_text: '', need_cold_chain: 0, cold_chain_note: '', tax_rate: 0 },
    };
  },
  computed: {
    productId() {
      return Number(this.$route.params.id);
    },
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      this.loading = true;
      freshGet(this.productId)
        .then((res) => {
          this.loading = false;
          this.form = { ...this.form, ...res.data };
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    save() {
      freshSave(this.productId, this.form)
        .then(() => {
          this.$message.success('保存成功');
          this.load();
        })
        .catch((err) => this.$message.error(err.msg));
    },
  },
};
</script>

<style lang="scss" scoped>
.gray {
  color: #909399;
  font-size: 12px;
  margin-left: 8px;
}
</style>
