<template>
  <div>
    <el-card shadow="never" class="ivu-mt" :body-style="{ padding: '16px' }">
      <el-alert
        v-if="healthTip"
        class="mb10"
        type="warning"
        :closable="false"
        show-icon
        :title="healthTip"
      />
      <el-alert
        class="mb10"
        type="info"
        :closable="false"
        show-icon
        title="提货仓库与「配送区域/区域价」分离：仓只负责次日提货点；价格仍在商品区域价配置。推荐先用「快速开仓」一城一仓，再进编辑挂多区/多仓。"
      />
      <div class="mb10">
        <el-input v-model="where.keyword" size="small" clearable placeholder="名称/编码/地址" style="width: 220px" @keyup.enter.native="search" />
        <el-select v-model="where.is_enable" size="small" clearable placeholder="启用状态" style="width: 120px" class="ml10">
          <el-option label="启用" :value="1" />
          <el-option label="停用" :value="0" />
        </el-select>
        <el-button size="small" type="primary" class="ml10" @click="search">查询</el-button>
        <el-button size="small" type="success" @click="openQuick">快速开仓</el-button>
        <el-button size="small" @click="openEdit()">新增仓库</el-button>
        <el-button size="small" @click="loadHealth">刷新健康检查</el-button>
      </div>
      <el-table :data="list" v-loading="loading" size="small" empty-text="暂无仓库">
        <el-table-column label="编码" prop="code" width="120" />
        <el-table-column label="名称" prop="name" min-width="140" />
        <el-table-column label="地址" min-width="180">
          <template slot-scope="scope">{{ scope.row.address }} {{ scope.row.detailed_address }}</template>
        </el-table-column>
        <el-table-column label="关联区划" width="90">
          <template slot-scope="scope">{{ scope.row.region_count }}</template>
        </el-table-column>
        <el-table-column label="自动匹配" width="90">
          <template slot-scope="scope">{{ scope.row.auto_match == 1 ? '是' : '否' }}</template>
        </el-table-column>
        <el-table-column label="仅精确" width="80">
          <template slot-scope="scope">{{ scope.row.exact_match_only == 1 ? '是' : '否' }}</template>
        </el-table-column>
        <el-table-column label="启用" width="70">
          <template slot-scope="scope">
            <el-tag size="mini" :type="scope.row.is_enable == 1 ? 'success' : 'info'">{{ scope.row.is_enable == 1 ? '启用' : '停用' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="220" fixed="right">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="openEdit(scope.row)">编辑</el-button>
            <el-button type="text" size="small" @click="$router.push({ path: $routeProStr + '/product/i18n/warehouse/' + scope.row.id })">多语</el-button>
            <el-button type="text" size="small" @click="del(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="acea-row row-right page">
        <pagination v-if="total" :total="total" :page.sync="where.page" :limit.sync="where.limit" @pagination="getList" />
      </div>
    </el-card>

    <el-dialog :title="form.id ? '编辑仓库' : '新增仓库'" :visible.sync="dlg" width="720px" @closed="form = blank()">
      <el-form label-width="110px" size="small">
        <el-form-item label="名称" required><el-input v-model="form.name" /></el-form-item>
        <el-form-item label="编码"><el-input v-model="form.code" placeholder="可选，如 WH-HN-01" /></el-form-item>
        <el-form-item label="电话"><el-input v-model="form.phone" /></el-form-item>
        <el-form-item label="地址"><el-input v-model="form.address" /></el-form-item>
        <el-form-item label="详细地址"><el-input v-model="form.detailed_address" /></el-form-item>
        <el-form-item label="启用"><el-switch v-model="form.is_enable" :active-value="1" :inactive-value="0" /></el-form-item>
        <el-collapse>
          <el-collapse-item title="高级选项（匹配/时段）" name="adv">
            <el-form-item label="说明"><el-input type="textarea" v-model="form.introduction" :rows="2" /></el-form-item>
            <el-form-item label="参与自动匹配"><el-switch v-model="form.auto_match" :active-value="1" :inactive-value="0" /></el-form-item>
            <el-form-item label="仅精确匹配"><el-switch v-model="form.exact_match_only" :active-value="1" :inactive-value="0" /></el-form-item>
            <el-form-item label="排序"><el-input-number v-model="form.sort" :min="0" /></el-form-item>
            <el-form-item label="生效开始"><el-input v-model.number="form.effective_start" placeholder="时间戳，0不限" /></el-form-item>
            <el-form-item label="生效结束"><el-input v-model.number="form.effective_end" placeholder="时间戳，0不限" /></el-form-item>
          </el-collapse-item>
        </el-collapse>
        <el-divider content-position="left">关联区划（任一级颗粒度）</el-divider>
        <div v-for="(r, i) in form.regions" :key="'rg-' + i + '-' + (r.city_id || 0)" class="mb10 region-row">
          <city-cascader v-model="r.city_id" width="360px" @change="(m) => onRegionMeta(r, m)" />
          <div class="acea-row row-middle mt6">
            <span class="gray mr8">排序</span>
            <el-input-number v-model="r.sort" :min="0" size="mini" />
            <el-checkbox v-model="r.is_default" :true-label="1" :false-label="0" class="ml10">该节点默认仓</el-checkbox>
            <el-button type="text" class="ml10" @click="form.regions.splice(i, 1)">移除</el-button>
          </div>
        </div>
        <el-button size="mini" @click="form.regions.push({ city_id: '', sort: 0, is_default: 0, level: null })">加关联</el-button>
      </el-form>
      <span slot="footer">
        <el-button @click="dlg = false">取消</el-button>
        <el-button type="primary" @click="submit">保存</el-button>
      </span>
    </el-dialog>

    <el-dialog title="快速开仓（一城一仓）" :visible.sync="quickDlg" width="560px">
      <el-form label-width="90px" size="small">
        <el-form-item label="仓名" required><el-input v-model="quick.name" /></el-form-item>
        <el-form-item label="地址"><el-input v-model="quick.address" /></el-form-item>
        <el-form-item label="电话"><el-input v-model="quick.phone" /></el-form-item>
        <el-form-item label="区划" required>
          <city-cascader v-model="quick.city_id" @change="onQuickMeta" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="quickDlg = false">取消</el-button>
        <el-button type="primary" @click="doQuick(false)">开仓</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import {
  warehouseList,
  warehouseSave,
  warehouseDelete,
  warehouseQuickCreate,
  warehouseHealth,
  warehouseRead,
} from '@/api/warehouse';
import CityCascader from '@/components/cityCascader/index.vue';

const blank = () => ({
  id: 0,
  code: '',
  name: '',
  address: '',
  detailed_address: '',
  introduction: '',
  phone: '',
  is_enable: 1,
  auto_match: 1,
  exact_match_only: 0,
  sort: 0,
  effective_start: 0,
  effective_end: 0,
  pickup_slots: [],
  regions: [],
});

export default {
  name: 'warehouseManage',
  components: { CityCascader },
  data() {
    return {
      where: { keyword: '', is_enable: '', page: 1, limit: 20 },
      list: [],
      total: 0,
      loading: false,
      dlg: false,
      form: blank(),
      quickDlg: false,
      quick: { name: '', address: '', phone: '', city_id: '', level: null },
      healthTip: '',
    };
  },
  created() {
    this.getList();
    this.loadHealth();
  },
  methods: {
    getList() {
      this.loading = true;
      warehouseList(this.where)
        .then((res) => {
          this.loading = false;
          this.list = res.data.list || [];
          this.total = res.data.count || 0;
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg || '加载失败');
        });
    },
    search() {
      this.where.page = 1;
      this.getList();
    },
    loadHealth() {
      warehouseHealth()
        .then((res) => {
          const d = res.data || {};
          const a = (d.no_warehouse || []).map((c) => c.name).join('、');
          const b = (d.no_default || []).map((c) => c.name).join('、');
          const tips = [];
          if (a) tips.push(`开放省级城无仓关联：${a}`);
          if (b) tips.push(`有仓未设默认：${b}`);
          this.healthTip = tips.join('；');
        })
        .catch(() => {
          this.healthTip = '';
        });
    },
    openEdit(row) {
      if (!row) {
        this.form = blank();
        this.dlg = true;
        return;
      }
      warehouseRead({ id: row.id }).then((res) => {
        const d = res.data || {};
        this.form = {
          ...blank(),
          ...d,
          regions: (d.regions || []).map((r) => ({
            city_id: r.city_id ? Number(r.city_id) : '',
            sort: r.sort,
            is_default: r.is_default ? 1 : 0,
            level: r.level,
            city_name: r.city_name || r.merger_name || '',
          })),
        };
        this.dlg = true;
      });
    },
    onRegionMeta(row, m) {
      if (!m) {
        row.level = null;
        row.city_name = '';
        return;
      }
      row.level = m.level;
      row.city_name = m.merger_name || m.name || '';
    },
    onQuickMeta(m) {
      this.quick.level = m ? m.level : null;
    },
    submit() {
      const payload = { ...this.form };
      payload.regions = (payload.regions || [])
        .filter((r) => r.city_id)
        .map((r) => ({ city_id: Number(r.city_id), sort: Number(r.sort) || 0, is_default: r.is_default ? 1 : 0 }));
      warehouseSave(payload)
        .then(() => {
          this.$message.success('保存成功');
          this.dlg = false;
          this.getList();
          this.loadHealth();
        })
        .catch((err) => this.$message.error(err.msg || '失败'));
    },
    del(row) {
      this.$confirm(`确认删除仓库「${row.name}」？`, '提示', { type: 'warning' })
        .then(() => warehouseDelete({ id: row.id }))
        .then(() => {
          this.$message.success('已删除');
          this.getList();
          this.loadHealth();
        })
        .catch(() => {});
    },
    openQuick() {
      this.quick = { name: '', address: '', phone: '', city_id: '', level: null };
      this.quickDlg = true;
    },
    doQuick(force) {
      if (!this.quick.city_id) return this.$message.warning('请选择区划');
      warehouseQuickCreate({
        name: this.quick.name,
        address: this.quick.address,
        phone: this.quick.phone,
        city_id: Number(this.quick.city_id),
        force: force ? 1 : 0,
      })
        .then((res) => {
          const d = res.data || {};
          if (d.need_confirm) {
            const prev = d.prev_default || {};
            this.$confirm(`该区域当前默认仓：${prev.name || prev.warehouse_id}，是否覆盖为新仓？`, '覆盖确认', {
              type: 'warning',
            })
              .then(() => this.doQuick(true))
              .catch(() => {});
            return;
          }
          this.$message.success('开仓成功');
          this.quickDlg = false;
          this.getList();
          this.loadHealth();
        })
        .catch((err) => this.$message.error(err.msg || '失败'));
    },
  },
};
</script>

<style scoped>
.region-row {
  padding: 8px 10px;
  background: #fafafa;
  border-radius: 4px;
}
.mt6 {
  margin-top: 6px;
}
.mr8 {
  margin-right: 8px;
}
.gray {
  color: #909399;
  font-size: 12px;
}
</style>
