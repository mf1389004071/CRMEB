<template>
	<view class="fresh-tags" v-if="show">
		<text class="origin" v-if="item.origin">{{ item.origin }}</text>
		<text class="cold" v-if="Number(item.need_cold_chain) === 1">{{ $t(`冷链`) }}</text>
		<text class="unit" v-if="item.unit_name">ĐVT: {{ item.unit_name }}</text>
		<text class="per" v-if="perUnit">≈ {{ perUnit }}/{{ item.unit_name }}</text>
	</view>
</template>

<script>
	import { formatMoney } from '@/utils/money.js';
	// 商品卡片生鲜标签（M7-3）：产地 + 需冷链角标 + 单位 + 折算单价（仅 net_weight>0）
	export default {
		name: 'FreshTags',
		props: {
			item: {
				type: Object,
				default: () => ({})
			}
		},
		computed: {
			show() {
				const i = this.item || {};
				return !!(i.origin || Number(i.need_cold_chain) === 1 || (Number(i.is_fresh) === 1 && i.unit_name));
			},
			// 折算单价 = 价格 / 净含量（本位币计算后再展示换算）
			perUnit() {
				const i = this.item || {};
				const w = Number(i.net_weight);
				const p = Number(i.price);
				if (!(w > 0) || isNaN(p)) return '';
				return formatMoney(p / w);
			}
		}
	};
</script>

<style lang="scss" scoped>
	.fresh-tags {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		font-size: 20rpx;
		color: #999;
		margin-top: 6rpx;

		text {
			margin-right: 10rpx;
		}

		.cold {
			color: #0070c0;
			border: 1px solid #0070c0;
			border-radius: 4rpx;
			padding: 0 6rpx;
		}

		.origin {
			color: #666;
		}
	}
</style>
