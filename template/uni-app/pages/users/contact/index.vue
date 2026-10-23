<template>
	<view :style="colorStyle" class="vn-contact">
		<view class="tip">{{ $t(`如需帮助，请通过以下方式联系我们`) }}</view>
		<view class="card" v-for="(item, index) in list" :key="index">
			<view class="row">
				<text class="type">{{ typeName(item.type) }}</text>
				<text class="account">{{ item.account }}</text>
			</view>
			<image v-if="item.qrcode_url" class="qrcode" :src="item.qrcode_url" mode="aspectFit"
				@click="preview(item.qrcode_url)"></image>
			<view class="btns" v-if="item.account">
				<view class="btn" @click="copy(item.account)">{{ $t(`复制`) }}</view>
				<view class="btn" v-if="item.type == 'phone'" @click="call(item.account)">{{ $t(`拨打电话`) }}</view>
			</view>
		</view>
		<view class="empty" v-if="loaded && !list.length">{{ $t(`暂未配置联系方式`) }}</view>
	</view>
</template>

<script>
	import colors from '@/mixins/color.js';
	import { getVnContacts } from '@/api/vn.js';

	export default {
		mixins: [colors],
		data() {
			return {
				list: [],
				loaded: false
			};
		},
		onLoad() {
			getVnContacts().then(res => {
				this.list = res.data || [];
				this.loaded = true;
			}).catch(() => {
				this.loaded = true;
			});
		},
		methods: {
			typeName(type) {
				const map = {
					zalo: 'Zalo',
					wechat: this.$t(`微信`),
					phone: this.$t(`电话`),
					email: this.$t(`邮箱`),
					facebook: 'Facebook'
				};
				return map[type] || type;
			},
			copy(text) {
				uni.setClipboardData({
					data: String(text),
					success: () => uni.showToast({ title: this.$t(`复制成功`), icon: 'none' })
				});
			},
			call(phone) {
				uni.makePhoneCall({ phoneNumber: String(phone) });
			},
			preview(url) {
				uni.previewImage({ urls: [url] });
			}
		}
	};
</script>

<style lang="scss" scoped>
	.vn-contact {
		padding: 24rpx;
		min-height: 100vh;
		background: #f5f5f5;

		.tip {
			color: #666;
			font-size: 26rpx;
			margin-bottom: 20rpx;
		}

		.card {
			background: #fff;
			border-radius: 16rpx;
			padding: 24rpx;
			margin-bottom: 20rpx;
		}

		.row {
			display: flex;
			justify-content: space-between;
			font-size: 30rpx;
			word-break: break-all;
		}

		.type {
			font-weight: 600;
			margin-right: 20rpx;
		}

		.qrcode {
			display: block;
			width: 320rpx;
			height: 320rpx;
			margin: 20rpx auto 0;
		}

		.btns {
			display: flex;
			justify-content: flex-end;
			margin-top: 16rpx;
		}

		.btn {
			margin-left: 20rpx;
			padding: 8rpx 24rpx;
			border: 1px solid #ccc;
			border-radius: 30rpx;
			font-size: 26rpx;
		}

		.empty {
			text-align: center;
			color: #999;
			margin-top: 100rpx;
		}
	}
</style>
