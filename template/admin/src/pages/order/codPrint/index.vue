<template>
  <div class="cod-print">
    <div class="toolbar no-print">
      <el-radio-group v-model="lang" size="small" @change="load">
        <el-radio-button label="vi-VN">Tiếng Việt</el-radio-button>
        <el-radio-button label="zh-CN">中文</el-radio-button>
        <el-radio-button label="both">中越对照</el-radio-button>
      </el-radio-group>
      <el-button type="primary" size="small" icon="el-icon-printer" @click="doPrint">打印 / 另存为 PDF</el-button>
      <el-button size="small" @click="mode = mode === 'notes' ? 'pick' : 'notes'">{{ mode === 'notes' ? '查看拣货汇总单' : '返回配送单' }}</el-button>
      <el-button size="small" @click="doExport('orders')">导出订单 Excel</el-button>
      <el-button size="small" @click="doExport('pick')">导出拣货 Excel</el-button>
      <span class="tip">共 {{ notes.length }} 单（配送单不含送达码）</span>
    </div>

    <div v-loading="loading">
      <!-- 配送单：每单一页 -->
      <template v-if="mode === 'notes'">
        <div class="page" v-for="n in notes" :key="n.id">
          <div class="head">
            <div class="title">{{ lang === 'zh-CN' ? '提货单' : lang === 'both' ? 'PHIẾU NHẬN HÀNG / 提货单' : 'PHIẾU NHẬN HÀNG' }}</div>
            <div class="oid">{{ n.order_id }}</div>
          </div>
          <table class="info">
            <tr>
              <td class="k">{{ L('Kho nhận hàng', '提货仓') }}</td>
              <td colspan="3">{{ n.warehouse_name || '-' }} <span v-if="n.warehouse_address">（{{ n.warehouse_address }}）</span></td>
            </tr>
            <tr>
              <td class="k">{{ L('Người nhận', '收货人') }}</td>
              <td>{{ n.real_name }}</td>
              <td class="k">{{ L('Điện thoại', '电话') }}</td>
              <td>{{ n.user_phone }}</td>
            </tr>
            <tr>
              <td class="k">{{ L('Địa chỉ', '地址') }}</td>
              <td colspan="3">{{ n.user_address }} <span v-if="n.region_name">（{{ n.region_name }}）</span></td>
            </tr>
            <tr>
              <td class="k">{{ L('Thời gian đặt', '下单时间') }}</td>
              <td>{{ n.add_time }}</td>
              <td class="k">{{ L('Ghi chú', '备注') }}</td>
              <td>{{ n.mark || '-' }} <b v-if="n.need_call_confirm" class="warn">{{ L('[Cần gọi xác nhận]', '[需电话确认]') }}</b></td>
            </tr>
          </table>
          <table class="goods">
            <thead>
              <tr>
                <th>#</th>
                <th>{{ L('Sản phẩm', '商品') }}</th>
                <th>{{ L('Quy cách', '规格') }}</th>
                <th>{{ L('ĐVT', '单位') }}</th>
                <th>{{ L('SL', '数量') }}</th>
                <th>{{ L('Đơn giá', '单价') }}</th>
                <th>{{ L('Thành tiền', '小计') }}</th>
                <th>{{ L('Xuất xứ / Bảo quản', '产地/储运') }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(g, i) in n.goods" :key="i">
                <td>{{ i + 1 }}</td>
                <td>
                  <div>{{ g.name }}</div>
                  <div class="sub" v-if="g.name_zh">{{ g.name_zh }}</div>
                </td>
                <td>{{ g.sku }}</td>
                <td>{{ g.unit }}</td>
                <td class="r">{{ g.num }}</td>
                <td class="r">{{ money(g.price) }}</td>
                <td class="r">{{ money(g.subtotal) }}</td>
                <td>
                  <span v-if="g.origin">{{ g.origin }}</span>
                  <b v-if="g.need_cold_chain" class="cold">{{ L('Lạnh', '冷链') }}</b>
                  <span v-if="g.shelf_life"> {{ g.shelf_life }}</span>
                </td>
              </tr>
            </tbody>
          </table>
          <table class="sum">
            <tr>
              <td>{{ L('Tiền hàng', '商品合计') }}</td>
              <td class="r">{{ money(n.goods_total) }} {{ n.base_currency }}</td>
            </tr>
            <tr>
              <td>{{ L('Phí vận chuyển', '运费') }}</td>
              <td class="r">{{ money(n.postage) }} {{ n.base_currency }}</td>
            </tr>
            <tr class="total">
              <td>{{ L('PHẢI THU (thanh toán khi nhận hàng)', '应收（货到付款）') }}</td>
              <td class="r">{{ money(n.receivable) }} {{ n.base_currency }}</td>
            </tr>
            <tr v-if="n.display_currency && n.display_currency !== n.base_currency && n.receivable_display">
              <td>{{ L('Tham khảo quy đổi', '参考折算') }}</td>
              <td class="r">≈ {{ n.receivable_display }} {{ n.display_currency }}</td>
            </tr>
          </table>
          <div class="sign">
            <div>{{ L('Người giao hàng', '配送员') }}: ________________</div>
            <div>{{ L('Khách hàng ký nhận', '客户签收') }}: ________________</div>
          </div>
        </div>
      </template>

      <!-- 拣货汇总单 -->
      <div class="page" v-else>
        <div class="head">
          <div class="title">{{ L('PHIẾU SOẠN HÀNG TỔNG HỢP', '拣货汇总单') }}</div>
          <div class="oid">{{ pickOrderCount }} {{ L('đơn', '单') }}</div>
        </div>
        <table class="goods">
          <thead>
            <tr>
              <th>#</th>
              <th>{{ L('Sản phẩm', '商品') }}</th>
              <th>{{ L('Quy cách', '规格') }}</th>
              <th>{{ L('ĐVT', '单位') }}</th>
              <th>{{ L('Tổng SL', '总数量') }}</th>
              <th>{{ L('Số đơn', '涉及订单') }}</th>
              <th>{{ L('Xuất xứ / Lạnh', '产地/冷链') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(g, i) in pick" :key="i">
              <td>{{ i + 1 }}</td>
              <td>
                <div>{{ g.name }}</div>
                <div class="sub" v-if="g.name_zh">{{ g.name_zh }}</div>
              </td>
              <td>{{ g.sku }}</td>
              <td>{{ g.unit }}</td>
              <td class="r big">{{ g.total_num }}</td>
              <td class="r">{{ g.order_count }}</td>
              <td>
                <span v-if="g.origin">{{ g.origin }}</span>
                <b v-if="g.need_cold_chain" class="cold">{{ L('Lạnh', '冷链') }}</b>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import { codPrintData, codPickSummary, codExportUrl } from '@/api/cod';

export default {
  name: 'codPrint',
  data() {
    return {
      lang: 'vi-VN',
      mode: 'notes',
      loading: false,
      notes: [],
      pick: [],
      pickOrderCount: 0,
    };
  },
  computed: {
    q() {
      const { ids, date, region_id, warehouse_id } = this.$route.query; // mode 仅用于前端展示
      return { ids, date, region_id, warehouse_id };
    },
  },
  created() {
    if (this.$route.query.mode === 'pick') this.mode = 'pick';
    this.load();
  },
  watch: {
    mode(v) {
      if (v === 'pick' && !this.pick.length) this.loadPick();
    },
  },
  methods: {
    // 按语言取文案：vi/zh 单语，both 为 “越 / 中”
    L(vi, zh) {
      if (this.lang === 'zh-CN') return zh;
      if (this.lang === 'both') return vi + ' / ' + zh;
      return vi;
    },
    money(v) {
      const n = Number(v);
      if (isNaN(n)) return v;
      return n.toLocaleString('en-US', { maximumFractionDigits: 2 });
    },
    load() {
      this.loading = true;
      codPrintData({ ...this.q, lang: this.lang })
        .then((res) => {
          this.notes = res.data || [];
          this.loading = false;
          if (this.mode === 'pick') this.loadPick();
        })
        .catch((err) => {
          this.loading = false;
          this.$message.error(err.msg);
        });
    },
    loadPick() {
      codPickSummary({ ...this.q, lang: this.lang })
        .then((res) => {
          this.pick = res.data.list || [];
          this.pickOrderCount = res.data.order_count || 0;
        })
        .catch((err) => this.$message.error(err.msg));
    },
    doPrint() {
      window.print();
    },
    doExport(type) {
      codExportUrl({ ...this.q, lang: this.lang, type })
        .then((res) => {
          window.open(res.data.url, '_blank');
        })
        .catch((err) => this.$message.error(err.msg));
    },
  },
};
</script>

<style lang="scss" scoped>
.cod-print {
  font-family: 'Segoe UI', 'Helvetica Neue', Arial, 'Noto Sans', 'Microsoft YaHei', sans-serif; /* 越南语变音符号 */
  .toolbar {
    padding: 12px 16px;
    background: #fff;
    border-bottom: 1px solid #eee;
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    align-items: center;
    .tip {
      color: #999;
      font-size: 12px;
    }
  }
  .page {
    width: 210mm;
    min-height: 297mm;
    margin: 12px auto;
    padding: 12mm;
    background: #fff;
    box-sizing: border-box;
    box-shadow: 0 0 6px rgba(0, 0, 0, 0.15);
    page-break-after: always;
    break-after: page;
    color: #222;
    font-size: 13px;
  }
  .head {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    border-bottom: 2px solid #222;
    padding-bottom: 6px;
    margin-bottom: 10px;
    .title {
      font-size: 20px;
      font-weight: 700;
    }
    .oid {
      font-size: 14px;
    }
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 10px;
  }
  .info td {
    padding: 4px 6px;
    border: 1px solid #ccc;
    .k {
      width: 90px;
    }
  }
  .info .k {
    width: 100px;
    background: #f5f5f5;
    font-weight: 600;
  }
  .goods th,
  .goods td {
    border: 1px solid #999;
    padding: 4px 6px;
    vertical-align: top;
  }
  .goods th {
    background: #f0f0f0;
    text-align: left;
  }
  .sub {
    color: #666;
    font-size: 12px;
  }
  .r {
    text-align: right;
  }
  .big {
    font-size: 16px;
    font-weight: 700;
  }
  .sum {
    width: 60%;
    margin-left: 40%;
    td {
      padding: 3px 6px;
      border-bottom: 1px dotted #aaa;
    }
    .total td {
      font-weight: 700;
      font-size: 15px;
      border-top: 2px solid #222;
    }
  }
  .sign {
    display: flex;
    justify-content: space-between;
    margin-top: 40px;
  }
  .warn {
    color: #d00;
  }
  .cold {
    color: #0070c0;
    border: 1px solid #0070c0;
    border-radius: 3px;
    padding: 0 3px;
    margin: 0 3px;
    font-size: 11px;
  }
}

@media print {
  .cod-print {
    .no-print {
      display: none !important;
    }
    .page {
      margin: 0;
      box-shadow: none;
      width: auto;
      min-height: auto;
      padding: 0;
    }
  }
}
</style>
