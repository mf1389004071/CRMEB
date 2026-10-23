<template>
	<view class="cate-grid" v-if="list.length">
		<view class="cell" v-for="c in list" :key="c.id" @click="go(c)">
			<image class="pic" :src="c.pic" mode="aspectFill" v-if="c.pic"></image>
			<view class="pic placeholder" v-else>{{ (c.cate_name || '').slice(0, 1) }}</view>
			<view class="name line1">{{ c.cate_name }}</view>
		</view>
	</view>
</template>

<script>
	import { getCategoryList } from '@/api/store.js';

	// 首页 8 宫格分类（图标 + 多语名称）：取前 8 个一级分类；名称由后端按 Cb-lang 本地化
	export default {
		name: 'CategoryGrid8',
		data() {
			return {
				list: []
			};
		},
		created() {
			getCategoryList().then((res) => {
				this.list = (res.data || []).slice(0, 8);
			}).catch(() => {});
		},
		methods: {
			go(c) {
				uni.navigateTo({
					url: '/pages/goods/goods_list/index?cid=' + c.id + '&title=' + encodeURIComponent(c.cate_name)
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.cate-grid {
		display: flex;
		flex-wrap: wrap;
		background: #fff;
		padding: 16rpx 8rpx;

		.cell {
			width: 25%;
			text-align: center;
			padding: 12rpx 0;
		}

		.pic {
			width: 96rpx;
			height: 96rpx;
			border-radius: 24rpx;
			margin: 0 auto;
			display: block;
			background: #f2f7f2;

			&.placeholder {
				line-height: 96rpx;
				color: #2e9e4b;
				font-weight: 700;
				font-size: 40rpx;
			}
		}

		.name {
			margin-top: 8rpx;
			font-size: 24rpx;
			padding: 0 6rpx;
		}
	}
</style>
