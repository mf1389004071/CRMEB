<template>
	<view :class="{ line: line, weight: weight }"
		:style="{color:color, fontFamily: SemiBold ? 'SemiBold' : 'Regular'}"
		class="base-money">
		<text v-show="preFix" class="preFix" :style="{'font-size': preFixSize + 'rpx','color':textColor}">{{preFix}}</text>
		<text v-if="symbol" class="symbol" :style="{'font-size': symbolSize +'rpx'}">{{ parts.symbol }}</text><text class="integer"
			:style="{'font-size': integerSize +'rpx'}">{{ parts.integer }}</text>
		<text v-if="digits && parts.decimal !== '' && ((isCoupon && !/^0+$/.test(parts.decimal)) || !isCoupon)" class="decimal"
			:style="{'font-size': decimalSize +'rpx'}">{{ parts.decSep }}{{ parts.decimal }}</text>
	</view>
</template>

<script>
	import { moneyParts } from '@/utils/money.js';
	export default {
		name: 'BaseMoney',
		props: {
			// 小数位数，为0则不显示
			digits: {
				type: Number,
				default: 2
			},
			money: {
				type: String | Number,
				default: ""
			},
			// 删除线
			line: {
				type: Boolean,
				default: false
			},
			// 粗体
			weight: {
				type: Boolean,
				default: false
			},
			symbol: {
				type: Boolean,
				default: true
			},
			color:{
				type: String,
				default: 'var(--view-theme)'
			},
			textColor:{
				type: String,
				default: '#999'
			},
			symbolSize: {
				type: String,
				default: '20'
			},
			integerSize: {
				type: String,
				default: '26'
			},
			decimalSize: {
				type: String,
				default: '24'
			},
			inline: {
				type: Boolean,
				default: false
			},
			preFix:{
				type: String,
				default: ''
			},
			preFixSize:{
				type: String,
				default: '24'
			},
			SemiBold:{
				type: Boolean,
				default: true
			},
			isCoupon:{
				type: Boolean,
				default: false
			}
		},
		// VN: 金额一律按本位币传入，由 utils/money.js 统一做币种换算/千分位/符号（不再手写 ￥ 与千分位）
		computed: {
			parts() {
				return moneyParts(this.money);
			}
		}
	}
</script>

<style lang="scss" scoped>
	.base-money {
		display: inline-block;
		&.line {
			text-decoration: line-through;
		}

		&.weight {
			font-weight: 500;
		}
	}
	.preFix{
		font-weight: 500 !important;
		font-family: PingFang SC-Medium, PingFang SC !important;
	}
	.SemiBold{
		font-family:'SemiBold';
	}
	.Regular{
		font-family:'Regular';
	}
</style>
