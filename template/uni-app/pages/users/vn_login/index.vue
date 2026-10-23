<template>
	<view class="vn-login" :style="colorStyle">
		<view class="shading">
			<image :src="logoUrl" v-if="logoUrl" />
			<view v-if="configData && configData.site_name" class="name">{{ configData.site_name }}</view>
		</view>
		<view class="whiteBg">
			<view class="tabs">
				<view class="tab" :class="{ on: mode === 'login' }" @click="mode = 'login'">{{ $t(`登录`) }}</view>
				<view class="tab" :class="{ on: mode === 'register' }" @click="mode = 'register'">{{ $t(`注册`) }}</view>
			</view>
			<view class="item phone">
				<picker :range="countryNames" :value="countryIndex" @change="onCountry">
					<view class="cc">{{ currentCountry.code }} <text class="arrow">▾</text></view>
				</picker>
				<input type="number" :placeholder="$t(`输入手机号码`)" v-model="account" maxlength="15" />
			</view>
			<view class="item" v-if="mode === 'register'">
				<input type="text" :placeholder="$t(`昵称(选填)`)" v-model="nickname" maxlength="30" />
			</view>
			<view class="item">
				<input type="password" :placeholder="$t(`填写登录密码`)" v-model="password" maxlength="32" />
			</view>
			<view class="forget" v-if="mode === 'login'">
				<navigator hover-class="none" url="/pages/users/retrievePassword/index">{{ $t(`忘记密码`) }}</navigator>
			</view>
			<view class="submit" @click="submit">{{ mode === 'login' ? $t(`登录`) : $t(`注册`) }}</view>
			<view class="protocol">
				<checkbox-group @change="protocol = !protocol">
					<checkbox :checked="protocol" />
					{{ $t(`已阅读并同意`) }}
					<text class="main-color" @click.stop="privacy(4)">{{ $t(`《用户协议》`) }}</text>
					{{ $t(`与`) }}
					<text class="main-color" @click.stop="privacy(3)">{{ $t(`《隐私协议》`) }}</text>
				</checkbox-group>
			</view>
		</view>
	</view>
</template>

<script>
	import colors from '@/mixins/color.js';
	import { loginH5, register, getUserInfo } from '@/api/user';
	import { getLogo } from '@/api/public';
	import { phoneCountries } from '@/api/vn.js';
	import Cache from '@/utils/cache';

	const BACK_URL = 'login_back_url';

	export default {
		name: 'VnLogin',
		mixins: [colors],
		data() {
			return {
				mode: 'login',
				countries: [
					{ code: '+84', name: 'Việt Nam (+84)' },
					{ code: '+86', name: '中国 (+86)' }
				],
				countryIndex: 0,
				account: '',
				password: '',
				nickname: '',
				protocol: false,
				logoUrl: '',
				locking: false,
				configData: Cache.get('BASIC_CONFIG')
			};
		},
		computed: {
			countryNames() {
				return this.countries.map((c) => c.name);
			},
			currentCountry() {
				return this.countries[this.countryIndex] || this.countries[0];
			}
		},
		onLoad() {
			phoneCountries().then((res) => {
				if (res.data && res.data.length) {
					this.countries = res.data.map((c) => ({ code: c.code, name: c.name + ' (' + c.code + ')' }));
				}
			}).catch(() => {});
			getLogo(2).then((res) => {
				this.logoUrl = res.data.logo_url;
			}).catch(() => {});
		},
		methods: {
			onCountry(e) {
				this.countryIndex = Number(e.detail.value);
			},
			privacy(type) {
				uni.navigateTo({ url: '/pages/users/privacy/index?type=' + type });
			},
			check() {
				if (!this.protocol) {
					this.$util.Tips({ title: this.$t('请先阅读并同意协议') });
					return false;
				}
				if (!this.account) {
					this.$util.Tips({ title: this.$t(`请输入手机号码`) });
					return false;
				}
				if (!this.password || this.password.length < 6) {
					this.$util.Tips({ title: this.$t(`密码至少6位`) });
					return false;
				}
				return true;
			},
			submit() {
				if (!this.check() || this.locking) return;
				this.locking = true;
				const payload = {
					account: this.account,
					password: this.password,
					phone_country_code: this.currentCountry.code,
					spread: this.$Cache.get('spread')
				};
				if (this.mode === 'register') {
					payload.nickname = this.nickname;
					register(payload).then(() => {
						this.$util.Tips({ title: this.$t(`注册成功`) });
						this.mode = 'login';
						this.locking = false;
						return this.doLogin(payload);
					}).catch((e) => {
						this.locking = false;
						this.$util.Tips({ title: e });
					});
				} else {
					this.doLogin(payload);
				}
			},
			doLogin(payload) {
				this.locking = true;
				return loginH5({
					account: payload.account,
					password: payload.password,
					phone_country_code: payload.phone_country_code,
					spread: payload.spread,
					agent_id: this.$Cache.get('agent_id') || 0
				}).then(({ data }) => {
					this.$store.commit('LOGIN', { token: data.token, time: data.expires_time - this.$Cache.time() });
					const backUrl = this.$Cache.get(BACK_URL) || '/pages/index/index';
					this.$Cache.clear(BACK_URL);
					return getUserInfo().then((res) => {
						this.locking = false;
						this.$store.commit('SETUID', res.data.uid);
						uni.reLaunch({ url: backUrl });
					});
				}).catch((e) => {
					this.locking = false;
					this.$util.Tips({ title: e });
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.vn-login {
		min-height: 100vh;
		background: #f5f5f5;

		.shading {
			text-align: center;
			padding: 80rpx 0 40rpx;

			image {
				width: 160rpx;
				height: 160rpx;
			}

			.name {
				margin-top: 16rpx;
				font-size: 32rpx;
				font-weight: 600;
			}
		}

		.whiteBg {
			background: #fff;
			margin: 0 40rpx;
			border-radius: 24rpx;
			padding: 30rpx;
		}

		.tabs {
			display: flex;
			margin-bottom: 20rpx;

			.tab {
				flex: 1;
				text-align: center;
				padding: 16rpx 0;
				font-size: 32rpx;
				color: #888;

				&.on {
					color: #e93323;
					font-weight: 700;
					border-bottom: 4rpx solid #e93323;
				}
			}
		}

		.item {
			display: flex;
			align-items: center;
			height: 96rpx;
			border-bottom: 1px solid #eee;

			input {
				flex: 1;
				font-size: 30rpx;
			}

			&.phone .cc {
				padding-right: 20rpx;
				margin-right: 20rpx;
				border-right: 1px solid #eee;
				font-weight: 600;
			}
		}

		.forget {
			text-align: right;
			font-size: 26rpx;
			color: #888;
			padding: 16rpx 0;
		}

		.submit {
			margin-top: 30rpx;
			height: 88rpx;
			line-height: 88rpx;
			text-align: center;
			color: #fff;
			background: #e93323;
			border-radius: 44rpx;
			font-size: 32rpx;
		}

		.protocol {
			margin-top: 30rpx;
			font-size: 24rpx;
			color: #666;
		}
	}
</style>
