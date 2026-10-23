<template>
	<view class="fresh-info" v-if="hasAny">
		<view class="title">{{ $t(`商品信息`) }}</view>
		<view class="row" v-if="fresh.origin">
			<text class="k">{{ $t(`产地`) }}</text>
			<text class="v">{{ fresh.origin }}</text>
		</view>
		<view class="row" v-if="fresh.shelf_life">
			<text class="k">{{ $t(`保质期`) }}</text>
			<text class="v">{{ fresh.shelf_life }}<text v-if="isDays"> {{ $t(`天`) }}</text></text>
		</view>
		<view class="row" v-if="Number(fresh.need_cold_chain) === 1">
			<text class="k">{{ $t(`冷链`) }}</text>
			<text class="v">{{ $t(`需冷链运输`) }}<text v-if="fresh.cold_chain_note">（{{ fresh.cold_chain_note }}）</text></text>
		</view>
		<view class="row" v-if="Number(fresh.net_weight) > 0">
			<text class="k">{{ $t(`净含量`) }}</text>
			<text class="v">{{ trimNum(fresh.net_weight) }} {{ fresh.unit_name }}</text>
		</view>
		<view class="row" v-if="fresh.unit_name">
			<text class="k">{{ $t(`单位`) }}</text>
			<text class="v">{{ fresh.unit_name }}</text>
		</view>
		<view class="row" v-if="Number(fresh.tax_rate) > 0">
			<text class="k">{{ $t(`税率`) }}</text>
			<text class="v">{{ trimNum(fresh.tax_rate) }}%</text>
		</view>
	</view>
</template>

<script>
	// 商品详情「商品信息」固定区块（M7-3）：产地/保质期/冷链/净含量/单位/税率；空值不显示；旧商品整体不显示
	export default {
		name: 'FreshInfo',
		props: {
			fresh: {
				type: Object,
				default: () => ({})
			}
		},
		computed: {
			hasAny() {
				const f = this.fresh || {};
				return !!(f.origin || f.shelf_life || Number(f.need_cold_chain) === 1 || Number(f.net_weight) > 0 || Number(f.tax_rate) > 0);
			},
			// 保质期仅为数字（来自天数）时追加“天”
			isDays() {
				return /^\d+$/.test(String((this.fresh || {}).shelf_life || ''));
			}
		},
		methods: {
			trimNum(v) {
				const n = Number(v);
				return isNaN(n) ? v : String(n);
			}
		}
	};
</script>

<style lang="scss" scoped>
	.fresh-info {
		background: #fff;
		margin: 20rpx;
		padding: 24rpx;
		border-radius: 16rpx;

		.title {
			font-weight: 700;
			margin-bottom: 12rpx;
		}

		.row {
			display: flex;
			padding: 8rpx 0;
			font-size: 26rpx;

			.k {
				width: 160rpx;
				color: #888;
			}

			.v {
				flex: 1;
				color: #333;
			}
		}
	}
</style>
