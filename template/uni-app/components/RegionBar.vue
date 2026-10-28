<template>
	<view class="home-head">
		<!-- 左侧：当前配送区域 + 地址摘要（点击进入选区页）；右侧：联系方式 -->
		<view class="region-bar">
			<view class="left" @click="goRegion">
				<text class="pin">📍</text>
				<view class="txt">
					<text class="lbl">{{ $t(`配送区域`) }}</text>
					<text class="val">{{ label || $t(`请选择配送区域`) }}</text>
					<text class="addr" v-if="addrText">{{ addrText }}</text>
				</view>
				<text class="arrow">›</text>
			</view>
			<view class="right-actions">
				<view class="contact" @click="goContact">☎</view>
				<!-- VN: 首页顶栏最右语言切换（与「我的」页 LangSwitcher 同源） -->
				<LangSwitcher icon-only />
			</view>
		</view>
		<!-- 中间：搜索 -->
		<view class="search" @click="goSearch">
			<text class="icon">🔍</text>
			<text class="ph">{{ $t(`搜索商品`) }}</text>
		</view>
	</view>
</template>

<script>
	import { getRegion, regionFullName } from '@/utils/region.js';
	import { getAddressDefault } from '@/api/user.js';
	import LangSwitcher from '@/components/LangSwitcher/index.vue';

	export default {
		name: 'RegionBar',
		components: {
			LangSwitcher
		},
		data() {
			return {
				label: '',
				addrText: ''
			};
		},
		created() {
			this.refresh();
		},
		methods: {
			refresh() {
				this.label = regionFullName(getRegion());
				// 已登录时展示默认收货地址摘要
				if (this.$store && this.$store.getters && this.$store.getters.isLogin) {
					getAddressDefault().then((res) => {
						const a = res.data || {};
						this.addrText = a.detail ? [a.district || a.city, a.detail].filter((x) => x).join(' · ') : '';
					}).catch(() => {});
				}
			},
			goRegion() {
				uni.navigateTo({
					url: '/pages/region/select'
				});
			},
			goSearch() {
				uni.navigateTo({
					url: '/pages/goods/goods_search/index'
				});
			},
			goContact() {
				uni.navigateTo({
					url: '/pages/users/contact/index'
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.home-head {
		background: #fff;
		padding-bottom: 12rpx;

		.region-bar {
			display: flex;
			align-items: center;
			padding: 16rpx 24rpx 8rpx;
			font-size: 26rpx;
		}

		.left {
			flex: 1;
			display: flex;
			align-items: center;
			overflow: hidden;
		}

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

		.addr {
			color: #888;
			font-size: 22rpx;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}

		.arrow {
			color: #bbb;
			font-size: 36rpx;
			margin: 0 10rpx;
		}

		.right-actions {
			display: flex;
			align-items: center;
			flex-shrink: 0;
			margin-left: 8rpx;
		}

		.contact {
			font-size: 40rpx;
			padding: 0 8rpx 0 12rpx;
		}

		.search {
			margin: 8rpx 24rpx 0;
			height: 68rpx;
			border-radius: 34rpx;
			background: #f2f2f2;
			display: flex;
			align-items: center;
			padding: 0 24rpx;
			color: #999;
			font-size: 26rpx;

			.icon {
				margin-right: 12rpx;
			}
		}
	}
</style>
