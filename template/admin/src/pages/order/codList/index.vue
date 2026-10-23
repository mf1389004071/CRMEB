<template>
  <div>
    <el-card :bordered="false" shadow="never" class="ivu-mt" :body-style="{ padding: 0 }">
      <div class="padding-add">
        <el-form :model="where" :label-width="labelWidth" :label-position="labelPosition" @submit.native.prevent inline>
          <el-form-item label="下单时间：">
            <el-date-picker
              clearable
              v-model="timeVal"
              type="daterange"
              :editable="false"
              format="yyyy-MM-dd"
              value-format="yyyy-MM-dd"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              style="width: 250px"
              @change="onTimeChange"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="关键字：">
            <el-input clearable v-model="where.keyword" placeholder="订单号/电话/姓名" class="form_content_width" @keyup.enter.native="search" />
          </el-form-item>
          <el-form-item label="配送区域ID：">
            <el-input clearable v-model="where.region_id" placeholder="区域 city_id" class="form_content_width" />
          </el-form-item>
          <el-form-item label="收款：">
            <el-select v-model="where.paid" clearable placeholder="全部" style="width: 110px">
              <el-option label="已收款" value="1" />
              <el-option label="未收款" value="0" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" v-db-click @click="search">查询</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <el-card :bordered="false" shadow="never" class="ivu-mt mt16">
      <div class="mb10">
        <el-button type="primary" size="small" icon="el-icon-printer" :disabled="!selection.length" @click="goPrint">批量打印配送单（{{ selection.length }}）</el-button>
        <el-button size="small" :disabled="!selection.length" @click="goPrint('pick')">批量拣货汇总</el-button>
        <el-button size="small" @click="printToday">打印今日全部</el-button>
        <el-switch v-model="soundOn" class="ml10" active-text="新订单提示音" @change="onSound" />
      </div>
      <el-tabs v-model="tab" @tab-click="onTab">
        <el-tab-pane v-for="t in tabs" :key="t.name" :name="t.name">
          <span slot="label">{{ t.label }}<el-badge :value="counts[t.count]" :max="999" class="cod-badge" v-if="counts[t.count]" /></span>
        </el-tab-pane>
      </el-tabs>

      <el-table :data="list" v-loading="loading" highlight-current-row @selection-change="onSelect" empty-text="暂无数据">
        <el-table-column type="selection" width="45" />
        <el-table-column label="订单号" min-width="170">
          <template slot-scope="scope">
            <div>{{ scope.row.order_id }}</div>
            <el-tag v-if="scope.row.need_call_confirm" size="mini" type="warning">需电话确认</el-tag>
            <el-tag v-if="scope.row.is_cancel" size="mini" type="info">已取消</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="收货信息" min-width="200">
          <template slot-scope="scope">
            <div>{{ scope.row.real_name }} {{ scope.row.user_phone }}</div>
            <div class="gray">{{ scope.row.user_address }}</div>
            <div class="gray" v-if="scope.row.mark">备注：{{ scope.row.mark }}</div>
          </template>
        </el-table-column>
        <el-table-column label="商品" min-width="180">
          <template slot-scope="scope">
            <div v-for="(g, i) in scope.row.goods" :key="i">{{ g.name }} <span class="gray">{{ g.suk }}</span> ×{{ g.num }}</div>
          </template>
        </el-table-column>
        <el-table-column label="区域" min-width="130" prop="region_name" />
        <el-table-column label="应收/实收" min-width="120">
          <template slot-scope="scope">
            <div>应收 {{ scope.row.cod_receivable }}</div>
            <div class="gray">实收 {{ scope.row.paid ? scope.row.cod_received : '-' }}</div>
          </template>
        </el-table-column>
        <el-table-column label="状态" min-width="120">
          <template slot-scope="scope">
            <el-tag size="small" :type="fulfilType(scope.row)">{{ fulfilText(scope.row) }}</el-tag>
            <el-tag size="small" :type="scope.row.paid ? 'success' : 'danger'" class="ml5">{{ scope.row.paid ? '已收款' : '未收款' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="下单时间" min-width="150" prop="add_time" />
        <el-table-column label="操作" min-width="260" fixed="right">
          <template slot-scope="scope">
            <template v-if="!scope.row.is_cancel">
              <el-button v-if="scope.row.fulfil_status === 0" type="text" size="small" @click="doConfirm(scope.row)">确认接单</el-button>
              <el-button v-if="scope.row.fulfil_status < 2" type="text" size="small" @click="openDelivering(scope.row)">开始配送</el-button>
              <el-button v-if="scope.row.fulfil_status < 3" type="text" size="small" @click="openVerify(scope.row)">核销</el-button>
              <el-button v-if="scope.row.fulfil_status < 3" type="text" size="small" @click="doDelivered(scope.row)">标记送达</el-button>
              <el-button v-if="!scope.row.paid && scope.row.fulfil_status > 0" type="text" size="small" @click="openCollect(scope.row)">确认收款</el-button>
              <el-button v-if="!scope.row.paid && scope.row.fulfil_status < 3" type="text" size="small" @click="openCancel(scope.row)">取消</el-button>
              <el-button type="text" size="small" @click="toggleCall(scope.row)">{{ scope.row.need_call_confirm ? '取消电话标记' : '电话确认' }}</el-button>
            </template>
            <el-button type="text" size="small" @click="openAudit(scope.row)">操作记录</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="acea-row row-right page">
        <pagination v-if="total" :total="total" :page.sync="where.page" :limit.sync="where.limit" @pagination="getList" />
      </div>
    </el-card>

    <el-dialog title="开始配送" :visible.sync="deliveringDlg" width="420px">
      <el-form label-width="90px">
        <el-form-item label="配送员"><el-input v-model="form.delivery_name" placeholder="姓名（可选）" /></el-form-item>
        <el-form-item label="司机电话"><el-input v-model="form.delivery_id" placeholder="电话（可选）" /></el-form-item>
      </el-form>
      <span slot="footer"><el-button @click="deliveringDlg = false">取消</el-button><el-button type="primary" @click="submitDelivering">确定</el-button></span>
    </el-dialog>

    <el-dialog title="送达核销" :visible.sync="verifyDlg" width="420px">
      <el-form label-width="90px">
        <el-form-item label="核销码"><el-input v-model="form.code" maxlength="6" placeholder="用户出示的 6 位送达码" /></el-form-item>
      </el-form>
      <span slot="footer"><el-button @click="verifyDlg = false">取消</el-button><el-button type="primary" @click="submitVerify">核销</el-button></span>
    </el-dialog>

    <el-dialog title="确认收款" :visible.sync="collectDlg" width="460px">
      <el-form label-width="90px">
        <el-form-item label="应收金额">{{ cur.cod_receivable }}</el-form-item>
        <el-form-item label="实收金额"><el-input v-model="form.received" placeholder="实收金额" /></el-form-item>
        <el-form-item label="差异原因"><el-input v-model="form.remark" type="textarea" placeholder="实收与应收不一致时必填" /></el-form-item>
      </el-form>
      <span slot="footer"><el-button @click="collectDlg = false">取消</el-button><el-button type="primary" @click="submitCollect">确认收款</el-button></span>
    </el-dialog>

    <el-dialog title="取消订单" :visible.sync="cancelDlg" width="420px">
      <el-form label-width="90px">
        <el-form-item label="取消原因"><el-input v-model="form.reason" type="textarea" placeholder="必填" /></el-form-item>
      </el-form>
      <span slot="footer"><el-button @click="cancelDlg = false">取消</el-button><el-button type="danger" @click="submitCancel">确认取消</el-button></span>
    </el-dialog>

    <el-dialog title="操作记录" :visible.sync="auditDlg" width="640px">
      <el-table :data="audits" size="small" empty-text="暂无记录">
        <el-table-column label="时间" prop="change_time_text" width="160" />
        <el-table-column label="类型" prop="change_type" width="130" />
        <el-table-column label="内容" prop="change_message" min-width="200" />
        <el-table-column label="操作人" width="130">
          <template slot-scope="scope">{{ scope.row.operator_name || '-' }} <span class="gray">({{ scope.row.operator_type || '-' }})</span></template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import { isSoundOn, setSoundOn } from '@/libs/codNotifier';
import { codList, codConfirm, codDelivering, codDelivered, codVerify, codCollect, codCancel, codCallMark, codAudit } from '@/api/cod';

export default {
  name: 'codList',
  data() {
    return {
      tab: 'all',
      tabs: [
        { name: 'pending', label: '待确认', count: 'pending', filter: { fulfil_status: 0 } },
        { name: 'stockup', label: '备货中', count: 'stockup', filter: { fulfil_status: 1 } },
        { name: 'delivering', label: '发货中', count: 'delivering', filter: { fulfil_status: 2 } },
        { name: 'delivered', label: '已送达', count: 'delivered', filter: { fulfil_status: 3 } },
        { name: 'uncollected', label: '待收款', count: 'uncollected', filter: { fulfil_status: 3, paid: 0 } },
        { name: 'all', label: '全部', count: 'all', filter: {} },
      ],
      counts: {},
      soundOn: isSoundOn(),
      where: { fulfil_status: '', region_id: '', date_start: '', date_end: '', keyword: '', paid: '', page: 1, limit: 20 },
      timeVal: [],
      list: [],
      total: 0,
      loading: false,
      selection: [],
      cur: {},
      form: { delivery_name: '', delivery_id: '', code: '', received: '', remark: '', reason: '' },
      deliveringDlg: false,
      verifyDlg: false,
      collectDlg: false,
      cancelDlg: false,
      auditDlg: false,
      audits: [],
    };
  },
  computed: {
    ...mapState('media', ['isMobile']),
    labelWidth() {
      return this.isMobile ? undefined : '90px';
    },
    labelPosition() {
      return this.isMobile ? 'top' : 'right';
    },
  },
  created() {
    this.getList();
  },
  methods: {
    onTimeChange(v) {
      this.timeVal = v || [];
      this.where.date_start = this.timeVal[0] || '';
      this.where.date_end = this.timeVal[1] || '';
      this.search();
    },
    onTab() {
      const t = this.tabs.find((x) => x.name === this.tab);
      this.where.fulfil_status = t.filter.fulfil_status !== undefined ? t.filter.fulfil_status : '';
      this.where.paid = t.filter.paid !== undefined ? String(t.filter.paid) : '';
      this.search();
    },
    search() {
      this.where.page = 1;
      this.getList();
    },
    getList() {
      this.loading = true;
      codList(this.where)
        .then((res) => {
          this.loading = false;
          this.list = res.data.list;
          this.total = res.data.count;
          this.counts = res.data.counts || {};
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    onSound(v) {
      setSoundOn(v);
    },
    goPrint(mode) {
      if (!this.selection.length) return;
      const ids = this.selection.map((r) => r.id).join(',');
      if (this.selection.length > 100) return this.$message.warning('一次最多打印100单');
      this.$router.push({ name: 'order_codPrint', query: { ids, mode: mode === 'pick' ? 'pick' : 'notes' } });
    },
    printToday() {
      const d = new Date();
      const p = (n) => (n < 10 ? '0' + n : n);
      this.$router.push({ name: 'order_codPrint', query: { date: `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}` } });
    },
    onSelect(rows) {
      this.selection = rows;
    },
    fulfilText(row) {
      if (row.is_cancel) return '已取消';
      if (row.status === 3) return '已完成';
      return ['待确认', '备货中', '发货中', '已送达'][row.fulfil_status] || '-';
    },
    fulfilType(row) {
      if (row.is_cancel) return 'info';
      return ['warning', '', 'primary', 'success'][row.fulfil_status] || '';
    },
    run(promise, okMsg) {
      return promise
        .then((res) => {
          this.$message.success(res.msg || okMsg || '操作成功');
          this.getList();
          return true;
        })
        .catch((err) => {
          this.$message.error(err.msg);
          return false;
        });
    },
    doConfirm(row) {
      this.run(codConfirm(row.id));
    },
    doDelivered(row) {
      this.$confirm('确认直接标记为已送达（不核对送达码）？', '提示', { type: 'warning' })
        .then(() => this.run(codDelivered(row.id)))
        .catch(() => {});
    },
    openDelivering(row) {
      this.cur = row;
      this.form.delivery_name = row.delivery_name || '';
      this.form.delivery_id = row.delivery_id || '';
      this.deliveringDlg = true;
    },
    submitDelivering() {
      this.run(codDelivering(this.cur.id, { delivery_name: this.form.delivery_name, delivery_id: this.form.delivery_id })).then((ok) => ok && (this.deliveringDlg = false));
    },
    openVerify(row) {
      this.cur = row;
      this.form.code = '';
      this.verifyDlg = true;
    },
    submitVerify() {
      this.run(codVerify({ order_id: this.cur.order_id, code: this.form.code }), '核销成功').then((ok) => ok && (this.verifyDlg = false));
    },
    openCollect(row) {
      this.cur = row;
      this.form.received = row.cod_receivable;
      this.form.remark = '';
      this.collectDlg = true;
    },
    submitCollect() {
      this.run(codCollect(this.cur.id, { received: String(this.form.received), remark: this.form.remark })).then((ok) => ok && (this.collectDlg = false));
    },
    openCancel(row) {
      this.cur = row;
      this.form.reason = '';
      this.cancelDlg = true;
    },
    submitCancel() {
      this.run(codCancel(this.cur.id, { reason: this.form.reason })).then((ok) => ok && (this.cancelDlg = false));
    },
    toggleCall(row) {
      this.run(codCallMark(row.id, { need: row.need_call_confirm ? 0 : 1 }));
    },
    openAudit(row) {
      codAudit(row.id)
        .then((res) => {
          this.audits = res.data;
          this.auditDlg = true;
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
}
.cod-badge {
  margin-left: 6px;
}
.ml5 {
  margin-left: 5px;
}
</style>
