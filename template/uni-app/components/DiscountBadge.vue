<template>
	<text class="discount-badge" v-if="percent > 0">-{{ percent }}%</text>
</template>

<script>
	// 商品卡折扣角标：由 ot_price(划线价) > price 计算 -xx%（区域价模式下 price/ot_price 均为区域价）
	export default {
		name: 'DiscountBadge',
		props: {
			item: {
				type: Object,
				default: () => ({})
			}
		},
		computed: {
			percent() {
				const p = Number((this.item || {}).price);
				const o = Number((this.item || {}).ot_price);
				if (!(o > 0) || !(p > 0) || o <= p) return 0;
				return Math.round((1 - p / o) * 100);
			}
		}
	};
</script>

<style lang="scss" scoped>
	.discount-badge {
		position: absolute;
		left: 0;
		top: 0;
		z-index: 2;
		background: #e93323;
		color: #fff;
		font-size: 20rpx;
		padding: 2rpx 10rpx;
		border-radius: 0 0 12rpx 0;
	}
</style>
