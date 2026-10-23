<template>
  <div class="region-price">
    <pages-header :title="'区域价格：' + (product.store_name || '')" :backUrl="$routeProStr + '/product/product_list'"></pages-header>
    <el-card :bordered="false" shadow="never" class="mt16" v-loading="loading">
      <div class="mb10">
        <el-alert
          type="info"
          :closable="false"
          show-icon
          title="按区域设置每个规格的售价。取价规则：就近取区域链上最近祖先的价格（国家 → 省 → 郡 → 坊），不借兄弟区域；链上无价则该区域不可售（除非开启下方“允许全国价”）。区域库存留空=沿用规格库存。"
        />
      </div>
      <div class="mb10 bar">
        <el-cascader
          ref="cascader"
          v-model="pickPath"
          :props="cascaderProps"
          placeholder="选择要设置价格的区域（国家/省/郡/坊 任一级）"
          clearable
          :show-all-levels="true"
          style="width: 420px"
        />
        <el-button type="primary" size="small" :disabled="!pickPath.length" @click="addCity">添加该区域</el-button>
        <el-divider direction="vertical" />
        <el-switch v-model="allowNational" :disabled="!systemAllow" active-text="允许全国价（无区域价时回落规格主价）" />
        <span class="gray" v-if="!systemAllow">（系统“允许全国价”总闸未开启，请先在 设置→越南站点 中开启）</span>
      </div>
      <div class="mb10">
        <el-button size="small" @click="downloadTemplate">下载导入模板</el-button>
        <el-upload class="inline-upload" action="" :show-file-list="false" :http-request="doImport" accept=".xlsx,.xls,.csv">
          <el-button size="small">Excel 导入</el-button>
        </el-upload>
        <el-button size="small" @click="doExport">导出本商品</el-button>
      </div>

      <el-empty v-if="!groups.length" description="尚未配置区域价：本商品在启用区域价时对所有区域不可售" />
      <div v-for="g in groups" :key="g.city_id" class="city-block">
        <div class="city-title">
          {{ g.city_name }} <span class="gray">(city_id {{ g.city_id }})</span>
          <el-button type="text" size="small" class="del" @click="removeCity(g)">移除该区域</el-button>
        </div>
        <el-table :data="g.rows" size="small" border>
          <el-table-column label="规格" min-width="160">
            <template slot-scope="scope">{{ skuName(scope.row.unique) }}</template>
          </el-table-column>
          <el-table-column label="主表价" width="110">
            <template slot-scope="scope">{{ skuBase(scope.row.unique) }}</template>
          </el-table-column>
          <el-table-column label="区域价*" width="150">
            <template slot-scope="scope"><el-input v-model="scope.row.price" size="mini" placeholder="必填 >0" /></template>
          </el-table-column>
          <el-table-column label="划线价" width="130">
            <template slot-scope="scope"><el-input v-model="scope.row.ot_price" size="mini" placeholder="可空" /></template>
          </el-table-column>
          <el-table-column label="区域库存" width="130">
            <template slot-scope="scope"><el-input v-model="scope.row.stock" size="mini" placeholder="空=沿用" /></template>
          </el-table-column>
          <el-table-column label="启用" width="80">
            <template slot-scope="scope"><el-switch v-model="scope.row.status" :active-value="1" :inactive-value="0" /></template>
          </el-table-column>
        </el-table>
      </div>
      <div class="mt16">
        <el-button type="primary" @click="save">保存区域价</el-button>
        <el-button @click="load">放弃修改</el-button>
      </div>
    </el-card>

    <el-dialog title="导入结果" :visible.sync="resultDlg" width="560px">
      <p>成功 {{ result.ok }} 行，失败 {{ result.fail.length }} 行</p>
      <el-table :data="result.fail" size="small" max-height="260">
        <el-table-column label="行号" prop="row" width="80" />
        <el-table-column label="原因" prop="reason" />
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { regionPriceGet, regionPriceSave, regionPriceTemplate, regionPriceExport, regionPriceImport } from '@/api/regionPrice';
import { regionList } from '@/api/region';

export default {
  name: 'productRegionPrice',
  data() {
    const self = this;
    return {
      loading: false,
      product: {},
      skus: [],
      groups: [],
      scope: [],
      systemAllow: false,
      allowNational: false,
      pickPath: [],
      resultDlg: false,
      result: { ok: 0, fail: [] },
      cascaderProps: {
        lazy: true,
        checkStrictly: true,
        value: 'city_id',
        label: 'name',
        leaf: 'leaf',
        lazyLoad(node, resolve) {
          const pid = node.level === 0 ? 0 : node.value;
          regionList({ parent_id: pid, limit: 500 })
            .then((res) => resolve(res.data.list.map((c) => ({ city_id: c.city_id, name: c.name, leaf: !c.has_children, merger_name: c.merger_name }))))
            .catch(() => resolve([]));
        },
      },
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
      regionPriceGet(this.productId)
        .then((res) => {
          this.loading = false;
          const d = res.data;
          this.product = d.product;
          this.skus = d.skus;
          this.systemAllow = d.system_allow;
          this.allowNational = !!d.product.allow_national_price;
          this.groups = d.groups.map((g) => ({ ...g, rows: g.rows.map((r) => ({ ...r, stock: r.stock === null ? '' : r.stock })) }));
          this.scope = this.groups.map((g) => g.city_id);
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    skuName(unique) {
      const s = this.skus.find((x) => x.unique === unique);
      return s ? s.suk : unique;
    },
    skuBase(unique) {
      const s = this.skus.find((x) => x.unique === unique);
      return s ? s.price : '';
    },
    addCity() {
      const cityId = this.pickPath[this.pickPath.length - 1];
      if (this.groups.find((g) => g.city_id === cityId)) return this.$message.warning('该区域已存在');
      const nodes = this.$refs.cascader ? this.$refs.cascader.getCheckedNodes() : [];
      const label = nodes.length ? nodes[0].pathLabels.join(',') : '区域 #' + cityId;
      this.groups.push({
        city_id: cityId,
        city_name: label,
        rows: this.skus.map((s) => ({ unique: s.unique, price: '', ot_price: '', stock: '', status: 1 })),
      });
      this.pickPath = [];
    },
    removeCity(g) {
      this.groups = this.groups.filter((x) => x.city_id !== g.city_id);
    },
    save() {
      const rows = [];
      for (const g of this.groups) {
        for (const r of g.rows) {
          // 价格为空的行视为“该规格在该区域不配价”，不提交（范围内已有的会被删除）
          if (r.price === '' || r.price === null) continue;
          rows.push({ unique: r.unique, city_id: g.city_id, price: r.price, ot_price: r.ot_price === '' ? 0 : r.ot_price, stock: r.stock === '' ? null : r.stock, status: r.status });
        }
      }
      const scope = Array.from(new Set(this.scope.concat(this.groups.map((g) => g.city_id))));
      regionPriceSave(this.productId, { rows, scope_city_ids: scope, allow_national_price: this.systemAllow ? (this.allowNational ? 1 : 0) : null })
        .then((res) => {
          this.$message.success('保存成功');
          this.load();
        })
        .catch((err) => this.$message.error(err.msg));
    },
    downloadTemplate() {
      regionPriceTemplate().then((res) => window.open(res.data.url, '_blank')).catch((err) => this.$message.error(err.msg));
    },
    doExport() {
      regionPriceExport({ product_id: this.productId }).then((res) => window.open(res.data.url, '_blank')).catch((err) => this.$message.error(err.msg));
    },
    doImport(opt) {
      const fd = new FormData();
      fd.append('file', opt.file);
      regionPriceImport(fd)
        .then((res) => {
          this.result = res.data;
          this.resultDlg = true;
          this.load();
        })
        .catch((err) => this.$message.error(err.msg));
    },
  },
};
</script>

<style lang="scss" scoped>
.bar {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  align-items: center;
}
.gray {
  color: #909399;
  font-size: 12px;
}
.city-block {
  margin-bottom: 18px;
}
.city-title {
  font-weight: 600;
  margin-bottom: 6px;
  .del {
    margin-left: 14px;
  }
}
.inline-upload {
  display: inline-block;
  margin: 0 8px;
}
</style>
