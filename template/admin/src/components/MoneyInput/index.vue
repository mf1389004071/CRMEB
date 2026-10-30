<template>
  <el-input
    :value="text"
    :size="size"
    :disabled="disabled"
    :clearable="clearable"
    :placeholder="placeholder"
    :class="['money-input', inputClass]"
    @focus="onFocus"
    @blur="onBlur"
    @input="onInput"
  >
    <template v-if="unit" slot="append">{{ unitText }}</template>
  </el-input>
</template>

<script>
import {
  formatMoneyInput,
  parseMoneyInput,
  baseCurrencySymbol,
  baseDecimalPlaces,
  getBaseCurrency,
} from '@/utils/money';

export default {
  name: 'MoneyInput',
  props: {
    value: { type: [Number, String], default: '' },
    min: { type: Number, default: 0 },
    max: { type: Number, default: 9999999999 },
    size: { type: String, default: '' },
    disabled: { type: Boolean, default: false },
    clearable: { type: Boolean, default: false },
    placeholder: { type: String, default: '' },
    inputClass: { type: String, default: '' },
    /** 是否显示币种后缀（替代原 class-unit="元"） */
    unit: { type: Boolean, default: true },
    /** 覆盖后缀文案；默认本位币符号 */
    unitLabel: { type: String, default: '' },
  },
  data() {
    return {
      focused: false,
      text: '',
    };
  },
  computed: {
    unitText() {
      return this.unitLabel || baseCurrencySymbol();
    },
  },
  watch: {
    value: {
      immediate: true,
      handler(v) {
        if (this.focused) return;
        this.text = this.format(v);
      },
    },
  },
  methods: {
    format(v) {
      if (v === '' || v === null || v === undefined) return '';
      const n = Number(v);
      if (isNaN(n)) return '';
      return formatMoneyInput(n, { code: getBaseCurrency() });
    },
    clamp(n) {
      if (n < this.min) return this.min;
      if (n > this.max) return this.max;
      const dp = baseDecimalPlaces();
      const f = Math.pow(10, dp);
      return Math.round((n + 1e-9) * f) / f;
    },
    onFocus() {
      this.focused = true;
      const raw = parseMoneyInput(this.value);
      this.text = raw === '' ? '' : String(raw);
      this.$emit('focus');
    },
    onInput(val) {
      // 编辑中允许数字、一个小数点、首位负号
      let s = String(val).replace(/[^\d.-]/g, '');
      const neg = s.startsWith('-');
      s = s.replace(/-/g, '');
      const parts = s.split('.');
      if (parts.length > 2) s = parts[0] + '.' + parts.slice(1).join('');
      if (neg) s = '-' + s;
      this.text = s;
      const parsed = parseMoneyInput(s);
      if (parsed === '') {
        this.$emit('input', '');
        return;
      }
      this.$emit('input', Number(parsed));
    },
    onBlur() {
      this.focused = false;
      const parsed = parseMoneyInput(this.text);
      if (parsed === '') {
        this.text = '';
        this.$emit('input', '');
        this.$emit('blur', '');
        return;
      }
      const n = this.clamp(Number(parsed));
      this.text = this.format(n);
      this.$emit('input', n);
      this.$emit('blur', n);
      this.$emit('change', n);
    },
  },
};
</script>

<style scoped>
.money-input {
  width: 100%;
}
</style>
