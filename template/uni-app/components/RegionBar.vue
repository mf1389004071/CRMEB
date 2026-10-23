<template>
	<view class="region-bar" @click="go">
		<text class="pin">📍</text>
		<view class="txt">
			<text class="lbl">{{ $t(`配送区域`) }}</text>
			<text class="val">{{ label || $t(`请选择配送区域`) }}</text>
		</view>
		<text class="arrow">›</text>
	</view>
</template>

<script>
	import { getRegion, regionFullName } from '@/utils/region.js';

	export default {
		name: 'RegionBar',
		data() {
			return {
				label: ''
			};
		},
		created() {
			this.refresh();
		},
		methods: {
			refresh() {
				this.label = regionFullName(getRegion());
			},
			go() {
				uni.navigateTo({
					url: '/pages/region/select'
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.region-bar {
		display: flex;
		align-items: center;
		padding: 16rpx 24rpx;
		background: #fff;
		font-size: 26rpx;

		.pin {
			margin-right: 10rpx;
		}

		.txt {
			flex: 1;
			display: flex;
			flex-direction: column;
			overflow: hidden;
		}

		.lbl {
			color: #999;
			font-size: 22rpx;
		}

		.val {
			font-weight: 600;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}

		.arrow {
			color: #bbb;
			font-size: 36rpx;
		}
	}
</style>
