<template>
	<view :style="colorStyle" class="cod-verify">
		<view class="box">
			<view class="label">{{ $t(`送达核销码或订单号`) }}</view>
			<input class="input" v-model="keyword" type="text" maxlength="40" :placeholder="$t(`请输入6位核销码或订单号`)" />
			<view class="row">
				<view class="btn ghost" @click="search">{{ $t(`查询订单`) }}</view>
				<view class="btn" :class="{ disabled: !order }" @click="verify">{{ $t(`确认送达核销`) }}</view>
			</view>
		</view>
		<view class="box" v-if="order">
			<view class="line"><text class="k">{{ $t(`订单号`) }}</text><text>{{ order.order_id }}</text></view>
			<view class="line"><text class="k">{{ $t(`收货人`) }}</text><text>{{ order.real_name }} {{ order.user_phone }}</text></view>
			<view class="line" v-if="order.user_address"><text class="k">{{ $t(`收货地址`) }}</text><text>{{ order.user_address }}</text></view>
			<view class="line"><text class="k">{{ $t(`应收金额(货到付款)`) }}</text><text class="amount">{{ $t(`￥`) }}{{ order.cod_receivable }}</text></view>
			<view class="line"><text class="k">{{ $t(`收款状态`) }}</text><text>{{ order.paid ? $t(`已收款`) : $t(`未收款`) }}</text></view>
		</view>
		<view class="box done" v-if="done">
			<view class="ok">{{ $t(`核销成功`) }}</view>
			<view class="tip">{{ $t(`请向客户收取货款，并在后台确认收款`) }}</view>
		</view>
	</view>
</template>

<script>
	import colors from '@/mixins/color.js';
	import { codVerifyDetail, codVerify } from '@/api/vn.js';

	export default {
		mixins: [colors],
		data() {
			return {
				keyword: '',
				order: null,
				done: false
			};
		},
		methods: {
			params() {
				const k = (this.keyword || '').trim();
				if (!k) {
					this.$util.Tips({ title: this.$t(`请输入6位核销码或订单号`) });
					return null;
				}
				return /^[0-9]{6}$/.test(k) ? { code: k } : { order_id: k };
			},
			search() {
				const p = this.params();
				if (!p) return;
				this.done = false;
				codVerifyDetail(p).then((res) => {
					this.order = res.data;
				}).catch((err) => {
					this.order = null;
					this.$util.Tips({ title: err });
				});
			},
			verify() {
				if (!this.order) return;
				const p = this.params();
				if (!p) return;
				// 订单号方式还需核销码：由客户出示，此处统一要求输入 6 位码
				if (!p.code) {
					this.$util.Tips({ title: this.$t(`请输入客户出示的6位核销码`) });
					return;
				}
				codVerify({ code: p.code }).then((res) => {
					this.order = res.data;
					this.done = true;
				}).catch((err) => {
					this.$util.Tips({ title: err });
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.cod-verify {
		padding: 24rpx;
		min-height: 100vh;
		background: #f5f5f5;

		.box {
			background: #fff;
			border-radius: 16rpx;
			padding: 24rpx;
			margin-bottom: 20rpx;
		}

		.label {
			font-size: 28rpx;
			margin-bottom: 16rpx;
		}

		.input {
			border: 1px solid #ddd;
			border-radius: 12rpx;
			height: 88rpx;
			padding: 0 20rpx;
			font-size: 36rpx;
			letter-spacing: 6rpx;
		}

		.row {
			display: flex;
			margin-top: 24rpx;
		}

		.btn {
			flex: 1;
			text-align: center;
			height: 80rpx;
			line-height: 80rpx;
			border-radius: 40rpx;
			background: #e93323;
			color: #fff;
			margin-left: 16rpx;

			&.ghost {
				background: #fff;
				color: #e93323;
				border: 1px solid #e93323;
				margin-left: 0;
			}

			&.disabled {
				opacity: 0.4;
			}
		}

		.line {
			display: flex;
			justify-content: space-between;
			padding: 10rpx 0;
			font-size: 28rpx;

			.k {
				color: #888;
				margin-right: 20rpx;
			}

			.amount {
				color: #e93323;
				font-weight: 700;
			}
		}

		.done {
			text-align: center;

			.ok {
				font-size: 40rpx;
				color: #1aad19;
				font-weight: 700;
			}

			.tip {
				margin-top: 12rpx;
				color: #666;
			}
		}
	}
</style>
