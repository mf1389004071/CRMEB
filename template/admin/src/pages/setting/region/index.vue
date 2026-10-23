<template>
  <div>
    <el-card :bordered="false" shadow="never" class="ivu-mt" :body-style="{ padding: '16px' }">
      <div class="mb10">
        <el-breadcrumb separator="/" class="crumb">
          <el-breadcrumb-item><a @click="goRoot">国家</a></el-breadcrumb-item>
          <el-breadcrumb-item v-for="(c, i) in crumbs" :key="c.city_id"
            ><a @click="goCrumb(i)">{{ c.name }}</a></el-breadcrumb-item
          >
        </el-breadcrumb>
      </div>
      <div class="mb10">
        <el-input v-model="where.keyword" size="small" clearable placeholder="按名称搜索（跨层级）" style="width: 220px" @keyup.enter.native="search" />
        <el-button size="small" type="primary" @click="search">搜索</el-button>
        <el-divider direction="vertical" />
        <el-button size="small" :disabled="!selection.length" @click="batchOpen(1, false)">批量开放</el-button>
        <el-button size="small" :disabled="!selection.length" @click="batchOpen(1, true)">开放（含下级）</el-button>
        <el-button size="small" :disabled="!selection.length" @click="batchOpen(0, true)">取消开放（含下级）</el-button>
        <el-button size="small" :disabled="!selection.length" @click="batchHot(1)">设为热门</el-button>
        <el-button size="small" :disabled="!selection.length" @click="batchHot(0)">取消热门</el-button>
        <el-divider direction="vertical" />
        <el-button size="small" @click="openAdd">新增下级</el-button>
        <el-upload class="inline-upload" action="" :show-file-list="false" :http-request="doImport" accept=".xlsx,.xls,.csv">
          <el-button size="small">Excel 导入</el-button>
        </el-upload>
        <el-button size="small" @click="doRebuild">重建 path</el-button>
        <span class="gray">导入列：city_id(可空)、parent_city_id、level、name、area_code、lng、lat、country_code</span>
      </div>
      <el-table :data="list" v-loading="loading" size="small" @selection-change="(r) => (selection = r)" empty-text="暂无数据">
        <el-table-column type="selection" width="45" />
        <el-table-column label="名称" min-width="200">
          <template slot-scope="scope">
            <a v-if="scope.row.has_children" class="link" @click="enter(scope.row)">{{ scope.row.name }} ›</a>
            <span v-else>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="city_id" prop="city_id" width="100" />
        <el-table-column label="层级" width="70" prop="level" />
        <el-table-column label="国家" width="70" prop="country_code" />
        <el-table-column label="经纬度" min-width="150">
          <template slot-scope="scope">{{ scope.row.lng }}, {{ scope.row.lat }}</template>
        </el-table-column>
        <el-table-column label="开放" width="80">
          <template slot-scope="scope"><el-switch :value="scope.row.is_open === 1" @change="(v) => toggleOpen(scope.row, v)" /></template>
        </el-table-column>
        <el-table-column label="热门" width="80">
          <template slot-scope="scope"><el-switch :value="scope.row.is_hot === 1" @change="(v) => toggleHot(scope.row, v)" /></template>
        </el-table-column>
        <el-table-column label="排序(大者靠前)" width="130">
          <template slot-scope="scope"><el-input-number size="mini" :controls="false" v-model="scope.row.sort" style="width: 80px" @change="() => saveSort(scope.row)" /></template>
        </el-table-column>
        <el-table-column label="编辑" width="70">
          <template slot-scope="scope"><el-button type="text" size="small" @click="openEdit(scope.row)">编辑</el-button></template>
        </el-table-column>
      </el-table>
      <div class="acea-row row-right page">
        <pagination v-if="total" :total="total" :page.sync="where.page" :limit.sync="where.limit" @pagination="getList" />
      </div>
    </el-card>

    <el-dialog :title="form.city_id ? '编辑区划' : '新增下级'" :visible.sync="dlg" width="460px">
      <el-form label-width="90px">
        <el-form-item label="名称"><el-input v-model="form.name" /></el-form-item>
        <el-form-item label="经度"><el-input v-model="form.lng" /></el-form-item>
        <el-form-item label="纬度"><el-input v-model="form.lat" /></el-form-item>
        <el-form-item label="区号"><el-input v-model="form.area_code" /></el-form-item>
      </el-form>
      <span slot="footer"><el-button @click="dlg = false">取消</el-button><el-button type="primary" @click="submit">保存</el-button></span>
    </el-dialog>

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
import { regionList, regionOpen, regionHot, regionSort, regionSave, regionImport, regionRebuildPath } from '@/api/region';

export default {
  name: 'regionManage',
  data() {
    return {
      where: { parent_id: 0, keyword: '', page: 1, limit: 100 },
      crumbs: [],
      list: [],
      total: 0,
      loading: false,
      selection: [],
      dlg: false,
      form: { city_id: 0, parent_id: 0, name: '', lng: '', lat: '', area_code: '' },
      resultDlg: false,
      result: { ok: 0, fail: [] },
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      regionList(this.where)
        .then((res) => {
          this.loading = false;
          this.list = res.data.list;
          this.total = res.data.count;
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    search() {
      this.where.page = 1;
      this.getList();
    },
    enter(row) {
      this.crumbs.push({ city_id: row.city_id, name: row.name });
      this.where.parent_id = row.city_id;
      this.where.keyword = '';
      this.search();
    },
    goRoot() {
      this.crumbs = [];
      this.where.parent_id = 0;
      this.search();
    },
    goCrumb(i) {
      this.crumbs = this.crumbs.slice(0, i + 1);
      this.where.parent_id = this.crumbs[i].city_id;
      this.search();
    },
    ids() {
      return this.selection.map((r) => r.city_id);
    },
    run(p) {
      return p
        .then((res) => {
          this.$message.success(res.msg || '操作成功');
          this.getList();
        })
        .catch((err) => this.$message.error(err.msg));
    },
    batchOpen(isOpen, cascade) {
      this.run(regionOpen({ ids: this.ids(), is_open: isOpen, cascade: cascade ? 1 : 0 }));
    },
    batchHot(isHot) {
      this.run(regionHot({ ids: this.ids(), is_hot: isHot }));
    },
    toggleOpen(row, v) {
      this.run(regionOpen({ ids: [row.city_id], is_open: v ? 1 : 0, cascade: 0 }));
    },
    toggleHot(row, v) {
      this.run(regionHot({ ids: [row.city_id], is_hot: v ? 1 : 0 }));
    },
    saveSort(row) {
      regionSort({ city_id: row.city_id, sort: row.sort || 0 }).catch((err) => this.$message.error(err.msg));
    },
    openAdd() {
      if (!this.where.parent_id) return this.$message.warning('请先进入某个国家/区划，再新增其下级');
      this.form = { city_id: 0, parent_id: this.where.parent_id, name: '', lng: '', lat: '', area_code: '' };
      this.dlg = true;
    },
    openEdit(row) {
      this.form = { city_id: row.city_id, parent_id: row.parent_id, name: row.name, lng: row.lng, lat: row.lat, area_code: row.area_code };
      this.dlg = true;
    },
    submit() {
      regionSave(this.form)
        .then(() => {
          this.dlg = false;
          this.getList();
        })
        .catch((err) => this.$message.error(err.msg));
    },
    doImport(opt) {
      const fd = new FormData();
      fd.append('file', opt.file);
      regionImport(fd)
        .then((res) => {
          this.result = res.data;
          this.resultDlg = true;
          this.getList();
        })
        .catch((err) => this.$message.error(err.msg));
    },
    doRebuild() {
      this.run(regionRebuildPath());
    },
  },
};
</script>

<style lang="scss" scoped>
.link {
  cursor: pointer;
  color: #409eff;
}
.gray {
  color: #909399;
  font-size: 12px;
  margin-left: 10px;
}
.inline-upload {
  display: inline-block;
  margin: 0 8px;
}
.crumb a {
  cursor: pointer;
}
</style>
