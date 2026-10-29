<template>
  <div class="i18n-edit">
    <pages-header :title="'多语内容：' + (data.title || '')" :backUrl="backUrl"></pages-header>
    <el-card :bordered="false" shadow="never" class="mt16" v-loading="loading">
      <el-alert
        type="info"
        :closable="false"
        show-icon
        class="mb10"
        :title="'主表字段保存站点默认语言（' + data.default_lang + '）内容；这里为各语言译文。留空=该语言不单独设置，前台按“当前语言 → 回落语言 → 主表”显示。机翻内容为“待审”状态，审核保存后转为已审核。'"
      />
      <el-alert
        v-if="corruptHint"
        type="warning"
        :closable="false"
        show-icon
        class="mb10"
        :title="corruptHint"
      />
      <div class="mb10">
        <el-button size="small" @click="machine" v-if="type !== 'city'">用中文机翻填充越/英（待审）</el-button>
        <el-button size="small" type="primary" @click="save">保存全部译文</el-button>
      </div>

      <el-tabs v-model="activeLang" type="card">
        <el-tab-pane v-for="l in data.langs" :key="l" :name="l">
          <span slot="label">{{ langLabel(l) }}<el-tag v-if="l === data.default_lang" size="mini" type="success" class="ml5">默认(必填)</el-tag></span>
          <el-form label-width="130px">
            <el-form-item v-for="f in data.fields" :key="f" :label="fieldLabel(f)">
              <div class="orig" v-if="l === data.default_lang">主表值：{{ data.original[f] }}</div>
              <el-input
                v-if="f !== 'description'"
                :type="f === 'store_info' || f === 'cold_chain_note' ? 'textarea' : 'text'"
                v-model="form[l][f]"
                :placeholder="l === data.default_lang ? '默认语言一般直接维护在主表，此处可留空' : '留空=不设置'"
              />
              <el-input v-else type="textarea" :rows="6" v-model="form[l][f]" placeholder="商品详情(HTML)，留空=回落" />
              <el-tag v-if="status[l] && status[l][f] === 0" size="mini" type="warning">待审(机翻)</el-tag>
            </el-form-item>
          </el-form>

          <template v-if="type === 'product' && data.attrs && data.attrs.length">
            <el-divider>规格名称/规格值（逗号分隔，数量与顺序须与原值一致）</el-divider>
            <el-form label-width="130px">
              <div v-for="a in data.attrs" :key="'a' + a.id" class="attr-block">
                <div class="orig">原规格：{{ a.attr_name }}：{{ a.attr_values }}</div>
                <el-form-item label="规格名"><el-input v-model="attrForm[a.id][l].attr_name" /></el-form-item>
                <el-form-item label="规格值"><el-input v-model="attrForm[a.id][l].attr_values" placeholder="如：500g,1kg" /></el-form-item>
              </div>
            </el-form>
            <el-divider>规格组合名（可选，覆盖自动组合）</el-divider>
            <el-form label-width="130px">
              <el-form-item v-for="s in data.skus" :key="'s' + s.id" :label="s.suk"><el-input v-model="skuForm[s.id][l]" placeholder="留空=按规格值自动组合" /></el-form-item>
            </el-form>
          </template>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { i18nRead, i18nWrite, i18nMachine } from '@/api/i18nContent';

const FIELD_LABELS = {
  store_name: '商品名称',
  store_info: '商品简介',
  unit_name: '单位',
  keyword: '关键字',
  origin: '产地',
  cold_chain_note: '冷链备注',
  shelf_life_text: '保质期文案',
  description: '商品详情',
  cate_name: '分类名称',
  name: '名称',
  merger_name: '合并名称',
  address: '地址',
  detailed_address: '详细地址',
  introduction: '说明',
};

export default {
  name: 'i18nEdit',
  data() {
    return {
      loading: false,
      data: { langs: [], fields: [], original: {}, translations: {}, attrs: [], skus: [], title: '', default_lang: 'vi-VN' },
      form: {},
      status: {},
      attrForm: {},
      skuForm: {},
      activeLang: 'vi-VN',
    };
  },
  computed: {
    type() {
      return this.$route.params.type;
    },
    id() {
      return Number(this.$route.params.id);
    },
    backUrl() {
      return this.type === 'product' ? this.$routeProStr + '/product/product_list' : this.type === 'category' ? this.$routeProStr + '/product/product_classify' : this.$routeProStr + '/setting/region/index';
    },
    /** 历史 SQL 非 utf8mb4 导入会把多字节字符写成「?」；在此提示，避免误以为切换逻辑坏了 */
    corruptHint() {
      const hits = [];
      const look = (label, val) => {
        const s = val == null ? '' : String(val);
        if (!s) return;
        if (/^\?+$/.test(s) || (s.length >= 4 && (s.match(/\?/g) || []).length >= Math.ceil(s.length / 2))) {
          hits.push(label);
        }
      };
      Object.keys(this.data.original || {}).forEach((f) => look('主表.' + f, this.data.original[f]));
      Object.keys(this.form || {}).forEach((l) => {
        Object.keys(this.form[l] || {}).forEach((f) => look(l + '.' + f, this.form[l][f]));
      });
      if (!hits.length) return '';
      return '检测到疑似编码损坏字段（含大量「?」）：' + hits.slice(0, 8).join('、') + '。请用 utf8mb4 重新保存译文，或重跑 demo/迁移 SQL；勿直接机翻坏掉的中文源。';
    },
  },
  created() {
    this.load();
  },
  methods: {
    langLabel(l) {
      return { 'vi-VN': 'Tiếng Việt', 'zh-CN': '中文', 'en-US': 'English' }[l] || l;
    },
    fieldLabel(f) {
      return FIELD_LABELS[f] || f;
    },
    load() {
      this.loading = true;
      i18nRead(this.type, this.id)
        .then((res) => {
          this.loading = false;
          const d = res.data;
          this.data = d;
          this.activeLang = d.default_lang;
          const form = {};
          const status = {};
          d.langs.forEach((l) => {
            form[l] = {};
            status[l] = {};
            d.fields.forEach((f) => {
              const t = d.translations[l] && d.translations[l][f];
              form[l][f] = t ? t.value : '';
              status[l][f] = t ? t.status : null;
            });
          });
          const attrForm = {};
          (d.attrs || []).forEach((a) => {
            attrForm[a.id] = {};
            d.langs.forEach((l) => {
              const t = a.translations[l] || {};
              attrForm[a.id][l] = { attr_name: t.attr_name ? t.attr_name.value : '', attr_values: t.attr_values ? t.attr_values.value : '' };
            });
          });
          const skuForm = {};
          (d.skus || []).forEach((s) => {
            skuForm[s.id] = {};
            d.langs.forEach((l) => {
              skuForm[s.id][l] = s.translations[l] && s.translations[l].suk ? s.translations[l].suk.value : '';
            });
          });
          this.form = form;
          this.status = status;
          this.attrForm = attrForm;
          this.skuForm = skuForm;
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    payload() {
      const attrs = {};
      Object.keys(this.attrForm).forEach((id) => (attrs[id] = this.attrForm[id]));
      const skus = {};
      Object.keys(this.skuForm).forEach((id) => {
        skus[id] = {};
        Object.keys(this.skuForm[id]).forEach((l) => (skus[id][l] = { suk: this.skuForm[id][l] }));
      });
      return { translations: this.form, attrs, skus };
    },
    save() {
      i18nWrite(this.type, this.id, this.payload())
        .then(() => {
          this.$message.success('保存成功');
          this.load();
        })
        .catch((err) => this.$message.error(err.msg));
    },
    machine() {
      this.$confirm('将以中文(无中文则用主表)为源，机翻填充越南语/英语，结果为“待审”状态，是否继续？', '提示', { type: 'warning' })
        .then(() => i18nMachine(this.type, this.id, { fields: this.data.fields.filter((f) => f !== 'description'), langs: ['vi-VN', 'en-US'] }))
        .then((res) => {
          this.$message.success(res.msg);
          this.load();
        })
        .catch((err) => err && err.msg && this.$message.error(err.msg));
    },
  },
};
</script>

<style lang="scss" scoped>
.orig {
  color: #909399;
  font-size: 12px;
  margin-bottom: 4px;
}
.attr-block {
  margin-bottom: 14px;
}
.ml5 {
  margin-left: 5px;
}
</style>
