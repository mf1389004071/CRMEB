<template>
	<view class="wf-item-page wf-page0">
		<view class='pictrue'>
			<DiscountBadge :item="item" />
			<easy-loadimage
			mode="widthFix"
			:image-src="item.image"
			width="100%"
			height="345rpx"
			borderRadius="16rpx 16rpx 0 0"></easy-loadimage>
		</view>
		<view class="info_box">
			<view class="w-full line2 fs-28 text--w111-333 lh-40rpx">
				<text v-if="item.brand_name" class="brand-tag">{{ item.brand_name }}</text>{{item.store_name}}
			</view>
			<FreshTags :item="item" />
			<view class="mt-8">
				<view class="flex-y-center flex-wrap mt-8">
					<baseMoney :money="item.price" symbolSize="24" integerSize="40" decimalSize="24" weight></baseMoney>
					<text v-if="Number(item.ot_price) > Number(item.price)" class="ot-price">{{ $money(item.ot_price) }}</text>
					<view class="inline-block h-26 lh-28rpx rd-14rpx bg--w111-F7E9CD fs-22 ml-8"
						v-if="!vnMode && Number(item.vip_price) > 0">
						<text class="inline-block h-26 lh-28rpx svip_rd fs-18 bg--w111-484643 text--w111-FDDAA4 px-8">SVIP</text>
						<text class="px-8 fs-22 SemiBold">¥{{item.vip_price}}</text>
					</view>
				</view>
				<view class="flex-between-center mt-12">
					<text class="fs-22 text--w111-999">{{$t('已售')}}{{item.sales}}{{item.unit_name}}</text>
					<!-- VN: 卡片内 − 数量 + 步进；多规格进详情选规格 -->
					<template v-if="vnMode && item.stock > 0">
						<view class="cart-step acea-row row-middle" v-if="!item.spec_type && cartNum > 0" @tap.stop>
							<view class="iconfont icon-jianhao step-btn" @tap.stop="changeNum(false)"></view>
							<view class="num">{{ cartNum }}</view>
							<view class="iconfont icon-jiahao step-btn" @tap.stop="changeNum(true)"></view>
						</view>
						<view class="w-44 h-44 rd-24 bg-gradient flex-center" v-else @tap.stop="addFirst">
							<text class="iconfont icon-ic_ShoppingCart1 text--w111-fff fs-26"></text>
						</view>
					</template>
					<template v-else>
						<view class="w-44 h-44 rd-24 bg-gradient flex-center" v-if="goDetail=='goDetail'">
							<text class="iconfont icon-ic_ShoppingCart1 text--w111-fff fs-26"></text>
						</view>
						<view class="w-44 h-44 rd-24 bg-gradient flex-center" @tap.stop="addCartChange" v-else>
							<text class="iconfont icon-ic_ShoppingCart1 text--w111-fff fs-26"></text>
						</view>
					</template>
				</view>
			</view>
		</view>
	</view>
</template>
<script>
	import easyLoadimage from '@/components/easy-loadimage/easy-loadimage.vue'
	import { mapGetters } from "vuex";
	import { HTTP_REQUEST_URL } from '@/config/app';
	import { postCartAdd } from '@/api/store.js';
	import { changeCartNum, cartDel } from '@/api/order.js';
	import { toLogin } from '@/libs/login.js';
	import { isVnMode } from '@/utils/vn.js';
	export default {
		components: {
			easyLoadimage
		},
		props: {
			item: {
				type: Object,
				require: true
			},
			type: {
				type: Number,
				default: 0
			},
			recommend:{
				type: Boolean,
				default: false
			},
			goDetail: {
				type: String,
				default: ''
			}
		},
		data() {
			return {
				domain: HTTP_REQUEST_URL,
				busy: false,
				localCartNum: null
			}
		},
		computed: {
			...mapGetters(['isLogin']),
			vnMode() {
				return isVnMode();
			},
			cartNum() {
				if (this.localCartNum !== null) return this.localCartNum;
				return Number(this.item.cart_num || 0);
			}
		},
		methods: {
			addCartChange(){
				this.$eventHub.$emit('onCartAddChange',this.item);
			},
			addFirst() {
				if (!this.isLogin) {
					toLogin();
					return;
				}
				if (this.item.spec_type) {
					uni.navigateTo({ url: `/pages/goods_details/index?id=${this.item.id}` });
					return;
				}
				this.changeNum(true);
			},
			changeNum(isAdd) {
				if (!this.isLogin) {
					toLogin();
					return;
				}
				if (this.busy) return;
				if (this.item.spec_type) {
					uni.navigateTo({ url: `/pages/goods_details/index?id=${this.item.id}` });
					return;
				}
				const next = isAdd ? this.cartNum + 1 : Math.max(0, this.cartNum - 1);
				this.busy = true;
				const cartId = this.item.cart_id;
				let req;
				if (!isAdd && next === 0 && cartId) {
					req = cartDel([cartId]);
				} else if (cartId && next > 0) {
					req = changeCartNum(cartId, next);
				} else {
					req = postCartAdd({ productId: this.item.id, cartNum: 1, uniqueId: this.item.unique || '', new: 1 });
				}
				req.then((res) => {
					this.localCartNum = next;
					if (res && res.data && (res.data.cartId || res.data.cart_id)) {
						this.$set(this.item, 'cart_id', res.data.cartId || res.data.cart_id);
					}
					if (next === 0) this.$set(this.item, 'cart_id', 0);
					this.$set(this.item, 'cart_num', this.localCartNum);
					try {
						const cur = Number(this.$store.state.indexData.cartNum || 0);
						this.$store.commit('indexData/setCartNum', String(Math.max(0, cur + (isAdd ? 1 : -1))));
					} catch (e) {}
				}).catch((err) => {
					this.$util && this.$util.Tips && this.$util.Tips({ title: (err && err.msg) || err || this.$t('操作失败') });
				}).finally(() => {
					this.busy = false;
				});
			}
		}
	}
</script>
<style lang="scss" scoped>
	.wf-item-page {
		background: #fff;
		overflow: hidden;
		border-radius: 20rpx;
	}
	.info_box{
		padding: 16rpx 20rpx;
		border-radius: 0 0 20rpx 20rpx;
		background-color: #fff;
	}
	.ot-price {
		color: #999;
		font-size: 22rpx;
		text-decoration: line-through;
		margin-left: 8rpx;
	}
	.cart-step {
		.step-btn {
			width: 44rpx;
			height: 44rpx;
			line-height: 44rpx;
			text-align: center;
			color: var(--view-theme);
			font-size: 40rpx;
		}
		.num {
			min-width: 36rpx;
			text-align: center;
			font-size: 26rpx;
		}
	}
	.text-primary-con{
		color: var(--view-theme);
	}
	.bg-primary-light{
		background: var(--view-minorColorT);
	}
	.bg--w111-484643{
		background: linear-gradient(90deg, #484643 0%, #1F1B17 100%);
	}
	.text--w111-FDDAA4{
		color: #FDDAA4;
	}
	.svip_rd{
		border-radius: 14rpx 0 8rpx 14rpx;
	}
</style>
