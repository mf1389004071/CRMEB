<template>
	<view :style="colorStyle">
		<view class="addAddress">
			<view class="list">
				<view class="item acea-row row-between-wrapper">
					<view class="name">{{ $t(`姓名`) }}</view>
					<input type="text" :placeholder="$t(`请输入姓名`)" v-model="form.real_name" maxlength="25" placeholder-class="placeholder" />
				</view>
				<view class="item acea-row row-between-wrapper">
					<view class="name">{{ $t(`联系电话`) }}</view>
					<picker :range="phoneCodeNames" :value="phoneCodeIndex" @change="onPhoneCode" class="cc">
						<view class="cc-val">{{ form.phone_country_code }} ▾</view>
					</picker>
					<input type="number" :placeholder="$t(`请输入联系电话`)" v-model="form.phone" maxlength="15" placeholder-class="placeholder" />
				</view>
				<view class="item acea-row row-between-wrapper">
					<view class="name">{{ $t(`所在地区`) }}</view>
					<view class="address">
						<RegionPicker :displayText="regionText" @change="onRegion" />
					</view>
				</view>
				<view class="item acea-row row-between-wrapper">
					<view class="name">{{ $t(`详细地址`) }}</view>
					<input type="text" :placeholder="$t(`请填写具体地址`)" v-model="form.detail" maxlength="200" placeholder-class="placeholder" />
				</view>
			</view>
			<view class="default acea-row row-middle" @click="form.is_default = !form.is_default">
				<checkbox-group>
					<checkbox :checked="!!form.is_default" />{{ $t(`设置为默认地址`) }}
				</checkbox-group>
			</view>
			<button class="keepBnt bg-color" @click="submit">{{ $t(`立即保存`) }}</button>
		</view>
	</view>
</template>

<script>
	import colors from '@/mixins/color.js';
	import RegionPicker from '@/components/RegionPicker.vue';
	import { editAddress, getAddressDetail } from '@/api/user.js';
	import { phoneCountries } from '@/api/vn.js';
	import { toLogin } from '@/libs/login.js';
	import { mapGetters } from 'vuex';

	// 越南站地址表单：国家 → 省/郡/坊逐级选择 + 区号手机号（省市区文本由服务端按 city_id 生成）
	export default {
		components: { RegionPicker },
		mixins: [colors],
		data() {
			return {
				id: 0,
				cartId: '',
				pinkId: 0,
				couponId: 0,
				news: '',
				noCoupon: 0,
				is_gift: 0,
				orderId: '',
				phoneCodes: [{ code: '+84', name: 'Việt Nam' }],
				phoneCodeIndex: 0,
				regionText: '',
				saving: false,
				form: {
					real_name: '',
					phone: '',
					phone_country_code: '+84',
					city_id: 0,
					detail: '',
					is_default: false
				}
			};
		},
		computed: {
			...mapGetters(['isLogin']),
			phoneCodeNames() {
				return this.phoneCodes.map((c) => `${c.code} ${c.name}`);
			}
		},
		onLoad(options) {
			if (!this.isLogin) {
				toLogin();
				return;
			}
			this.cartId = options.cartId || '';
			this.pinkId = options.pinkId || 0;
			this.couponId = options.couponId || 0;
			this.id = options.id || 0;
			this.noCoupon = options.noCoupon || 0;
			this.news = options.new || '';
			this.is_gift = options.is_gift || '';
			this.orderId = options.order_id || '';
			uni.setNavigationBarTitle({
				title: this.id ? this.$t(`修改地址`) : this.$t(`添加地址`)
			});
			phoneCountries().then((res) => {
				if (res.data && res.data.length) {
					this.phoneCodes = res.data;
					const i = this.phoneCodes.findIndex((c) => c.code === this.form.phone_country_code);
					this.phoneCodeIndex = i > -1 ? i : 0;
				}
			}).catch(() => {});
			if (this.id) {
				getAddressDetail(this.id).then((res) => {
					const a = res.data;
					this.form.real_name = a.real_name;
					this.form.phone = a.phone;
					this.form.phone_country_code = a.phone_country_code || '+84';
					this.form.city_id = a.city_id;
					this.form.detail = a.detail;
					this.form.is_default = !!a.is_default;
					this.regionText = [a.province, a.city, a.district].filter((x) => x).join(' · ');
					const i = this.phoneCodes.findIndex((c) => c.code === this.form.phone_country_code);
					if (i > -1) this.phoneCodeIndex = i;
				});
			}
		},
		methods: {
			onPhoneCode(e) {
				this.phoneCodeIndex = Number(e.detail.value);
				this.form.phone_country_code = this.phoneCodes[this.phoneCodeIndex].code;
			},
			onRegion(r) {
				if (r) {
					this.form.city_id = r.city_id;
					this.regionText = r.text;
				} else {
					this.form.city_id = 0;
					this.regionText = '';
				}
			},
			submit() {
				const f = this.form;
				if (!f.real_name.trim()) return this.$util.Tips({ title: this.$t(`请填写收货人姓名`) });
				if (!f.phone) return this.$util.Tips({ title: this.$t(`请填写联系电话`) });
				if (!f.city_id) return this.$util.Tips({ title: this.$t(`请选择所在地区`) });
				if (!f.detail.trim()) return this.$util.Tips({ title: this.$t(`请填写详细地址`) });
				if (this.saving) return;
				this.saving = true;
				uni.showLoading({ title: this.$t(`保存中`), mask: true });
				editAddress({
					id: this.id,
					real_name: f.real_name.trim(),
					phone: f.phone,
					phone_country_code: f.phone_country_code,
					city_id: f.city_id,
					detail: f.detail.trim(),
					is_default: f.is_default ? 1 : 0
				}).then((res) => {
					this.saving = false;
					this.$util.Tips({ title: this.$t(this.id ? `修改成功` : `添加成功`), icon: 'success' });
					setTimeout(() => {
						if (this.cartId) {
							uni.navigateTo({
								url: '/pages/goods/order_confirm/index?new=' + this.news + '&cartId=' + this.cartId + '&addressId=' + (this.id ? this.id : res.data.id) +
									'&pinkId=' + this.pinkId + '&couponId=' + this.couponId + '&noCoupon=' + this.noCoupon + '&is_gift=' + this.is_gift + '&order_id=' + this.orderId
							});
						} else {
							// #ifdef H5
							return history.back();
							// #endif
							// #ifndef H5
							return uni.navigateBack({ delta: 1 });
							// #endif
						}
					}, 800);
				}).catch((err) => {
					this.saving = false;
					uni.hideLoading();
					this.$util.Tips({ title: err });
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.addAddress {
		padding: 20rpx;

		.list {
			background: #fff;
			border-radius: 16rpx;
			padding: 0 24rpx;
		}

		.item {
			min-height: 100rpx;
			border-bottom: 1px solid #eee;

			.name {
				width: 160rpx;
				font-size: 28rpx;
			}

			input,
			.address {
				flex: 1;
				font-size: 28rpx;
			}

			.cc-val {
				padding-right: 16rpx;
				color: #333;
				font-weight: 600;
			}
		}

		.default {
			margin: 24rpx 4rpx;
		}

		.keepBnt {
			margin-top: 30rpx;
			height: 88rpx;
			line-height: 88rpx;
			border-radius: 44rpx;
			color: #fff;
		}
	}
</style>
