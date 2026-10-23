<template>
  <div>
    <el-card :bordered="false" shadow="never" class="ivu-mt" :body-style="{ padding: '16px' }">
      <el-alert
        type="info"
        :closable="false"
        show-icon
        class="mb10"
        title="价格、订单、应付一律使用本位币；展示币种只在前台展示层按汇率换算（汇率含义：1 本位币 = rate 该币种）。订单创建时会固化币种/汇率快照，后续改汇率不影响历史订单。本位币唯一且不可删除。"
      />
      <div class="mb10">
        <el-button type="primary" size="small" @click="openAdd">新增币种</el-button>
        <el-button size="small" @click="openLogs('')">汇率修改日志</el-button>
      </div>
      <el-table :data="list" v-loading="loading" size="small" empty-text="暂无数据">
        <el-table-column label="币种码" prop="code" width="90" />
        <el-table-column label="符号" prop="symbol" width="70" />
        <el-table-column label="名称" min-width="200">
          <template slot-scope="scope">{{ scope.row.name_zh }} / {{ scope.row.name_vi }} / {{ scope.row.name_en }}</template>
        </el-table-column>
        <el-table-column label="小数位" prop="decimal_places" width="80" />
        <el-table-column label="千分位/小数点" width="120">
          <template slot-scope="scope">{{ scope.row.thousand_sep }} / {{ scope.row.decimal_sep }}</template>
        </el-table-column>
        <el-table-column label="汇率(1本位币=)" prop="rate" width="140" />
        <el-table-column label="本位币" width="80">
          <template slot-scope="scope"><el-tag v-if="scope.row.is_base == 1" size="mini" type="success">本位币</el-tag></template>
        </el-table-column>
        <el-table-column label="状态" width="80">
          <template slot-scope="scope"><el-tag size="mini" :type="scope.row.status == 1 ? '' : 'info'">{{ scope.row.status == 1 ? '启用' : '停用' }}</el-tag></template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="openEdit(scope.row)">编辑</el-button>
            <el-button type="text" size="small" @click="openLogs(scope.row.code)">日志</el-button>
            <el-button type="text" size="small" v-if="scope.row.is_base != 1" @click="del(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog :title="form.id ? '编辑币种' : '新增币种'" :visible.sync="dlg" width="520px">
      <el-form label-width="110px">
        <el-form-item label="币种码"><el-input v-model="form.code" :disabled="!!form.id" maxlength="3" placeholder="3位大写字母，如 USD" /></el-form-item>
        <el-form-item label="符号"><el-input v-model="form.symbol" /></el-form-item>
        <el-form-item label="中文名"><el-input v-model="form.name_zh" /></el-form-item>
        <el-form-item label="越南语名"><el-input v-model="form.name_vi" /></el-form-item>
        <el-form-item label="英文名"><el-input v-model="form.name_en" /></el-form-item>
        <el-form-item label="小数位"><el-input-number v-model="form.decimal_places" :min="0" :max="6" /></el-form-item>
        <el-form-item label="千分位符"><el-input v-model="form.thousand_sep" maxlength="2" style="width: 100px" /></el-form-item>
        <el-form-item label="小数点符"><el-input v-model="form.decimal_sep" maxlength="2" style="width: 100px" /></el-form-item>
        <el-form-item label="汇率"><el-input v-model="form.rate" :disabled="form.is_base == 1" placeholder="1 本位币 = ? 该币种" /></el-form-item>
        <el-form-item label="排序"><el-input-number v-model="form.sort" :min="0" /></el-form-item>
        <el-form-item label="启用"><el-switch v-model="form.status" :active-value="1" :inactive-value="0" :disabled="form.is_base == 1" /></el-form-item>
      </el-form>
      <span slot="footer"><el-button @click="dlg = false">取消</el-button><el-button type="primary" @click="submit">保存</el-button></span>
    </el-dialog>

    <el-dialog title="汇率修改日志" :visible.sync="logDlg" width="620px">
      <el-table :data="logs" size="small" max-height="360" empty-text="暂无记录">
        <el-table-column label="时间" prop="add_time_text" width="160" />
        <el-table-column label="币种" prop="code" width="80" />
        <el-table-column label="原汇率" prop="old_rate" />
        <el-table-column label="新汇率" prop="new_rate" />
        <el-table-column label="操作人ID" prop="operator_id" width="90" />
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { currencyList, currencySave, currencyDel, currencyLogs } from '@/api/currency';

const blank = () => ({ id: 0, code: '', symbol: '', name_zh: '', name_vi: '', name_en: '', decimal_places: 2, thousand_sep: ',', decimal_sep: '.', rate: '', is_base: 0, status: 1, sort: 0 });

export default {
  name: 'currencyManage',
  data() {
    return { list: [], loading: false, dlg: false, form: blank(), logDlg: false, logs: [] };
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      this.loading = true;
      currencyList()
        .then((res) => {
          this.loading = false;
          this.list = res.data;
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    openAdd() {
      this.form = blank();
      this.dlg = true;
    },
    openEdit(row) {
      this.form = { ...row };
      this.dlg = true;
    },
    submit() {
      currencySave(this.form)
        .then(() => {
          this.$message.success('保存成功');
          this.dlg = false;
          this.load();
        })
        .catch((err) => this.$message.error(err.msg));
    },
    del(row) {
      this.$confirm(`确认删除币种 ${row.code}？`, '提示', { type: 'warning' })
        .then(() => currencyDel(row.id))
        .then(() => {
          this.$message.success('已删除');
          this.load();
        })
        .catch((err) => err && err.msg && this.$message.error(err.msg));
    },
    openLogs(code) {
      currencyLogs({ code })
        .then((res) => {
          this.logs = res.data;
          this.logDlg = true;
        })
        .catch((err) => this.$message.error(err.msg));
    },
  },
};
</script>
