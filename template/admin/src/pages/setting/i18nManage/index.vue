<template>
  <div>
    <el-card :bordered="false" shadow="never" class="ivu-mt" :body-style="{ padding: '16px' }">
      <div class="bar mb10">
        <el-select v-model="where.type" size="small" style="width: 120px" @change="onType">
          <el-option label="商品" value="product" />
          <el-option label="分类" value="category" />
        </el-select>
        <el-select v-model="where.lang" size="small" style="width: 130px">
          <el-option label="Tiếng Việt" value="vi-VN" />
          <el-option label="中文" value="zh-CN" />
          <el-option label="English" value="en-US" />
        </el-select>
        <el-select v-model="where.field" size="small" style="width: 150px">
          <el-option v-for="f in fieldOptions" :key="f.value" :label="f.label" :value="f.value" />
        </el-select>
        <el-button type="primary" size="small" @click="load">查看缺译文</el-button>
        <el-divider direction="vertical" />
        <el-button size="small" @click="doExport">导出译文 Excel</el-button>
        <el-upload class="inline-upload" action="" :show-file-list="false" :http-request="doImport" accept=".xlsx,.xls,.csv">
          <el-button size="small">导入译文 Excel</el-button>
        </el-upload>
        <span class="gray">列：entity_type, entity_id, field, lang, value</span>
      </div>
      <el-table :data="list" v-loading="loading" size="small" empty-text="没有缺失的译文 🎉">
        <el-table-column label="ID" prop="id" width="100" />
        <el-table-column label="名称" prop="title" min-width="260" />
        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <router-link :to="{ path: $routeProStr + '/product/i18n/' + where.type + '/' + scope.row.id }"><a>去补译文</a></router-link>
          </template>
        </el-table-column>
      </el-table>
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
import { i18nMissing, i18nExport, i18nImport } from '@/api/i18nContent';

export default {
  name: 'i18nManage',
  data() {
    return {
      where: { type: 'product', lang: 'en-US', field: 'store_name' },
      list: [],
      loading: false,
      resultDlg: false,
      result: { ok: 0, fail: [] },
    };
  },
  computed: {
    fieldOptions() {
      return this.where.type === 'category'
        ? [{ value: 'cate_name', label: '分类名称' }]
        : [
            { value: 'store_name', label: '商品名称' },
            { value: 'store_info', label: '商品简介' },
            { value: 'unit_name', label: '单位' },
            { value: 'description', label: '商品详情' },
          ];
    },
  },
  created() {
    this.load();
  },
  methods: {
    onType() {
      this.where.field = this.fieldOptions[0].value;
      this.load();
    },
    load() {
      this.loading = true;
      i18nMissing(this.where)
        .then((res) => {
          this.loading = false;
          this.list = res.data;
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    doExport() {
      i18nExport({ type: this.where.type })
        .then((res) => window.open(res.data.url, '_blank'))
        .catch((err) => this.$message.error(err.msg));
    },
    doImport(opt) {
      const fd = new FormData();
      fd.append('file', opt.file);
      i18nImport(fd)
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
.inline-upload {
  display: inline-block;
}
</style>
