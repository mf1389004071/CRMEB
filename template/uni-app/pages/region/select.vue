<template>
	<view class="region-select" :style="colorStyle">
		<view class="locate-bar">
			<view class="locate-btn" @click="locate">
				<text class="iconfont icon-dingwei"></text>
				{{ locating ? $t(`正在定位…`) : $t(`定位当前位置`) }}
			</view>
			<view class="locate-tip" v-if="locateMsg">{{ locateMsg }}</view>
			<view class="locate-result" v-if="located" @click="choose(located.node, located.chain)">
				{{ $t(`定位到`) }}：{{ located.node.name }}（{{ $t(`点击选择`) }}）
			</view>
		</view>

		<view class="section" v-if="hot.length">
			<view class="title">{{ $t(`热门城市`) }}</view>
			<view class="grid">
				<view class="cell" v-for="h in hot" :key="h.city_id" :class="{ on: current && current.city_id === h.city_id }" @click="pickHot(h)">{{ h.name }}</view>
			</view>
		</view>

		<view class="section">
			<view class="title">{{ $t(`全部地区`) }}</view>
			<view class="crumbs" v-if="stack.length">
				<text class="crumb" @click="up(-1)">{{ $t(`全部`) }}</text>
				<text v-for="(s, i) in stack" :key="s.city_id" class="crumb" @click="up(i)"> › {{ s.name }}</text>
			</view>
			<view class="pick-here" v-if="stack.length && stack.length >= 1" @click="chooseStackTop">
				{{ $t(`选择`) }}「{{ stack[stack.length - 1].name }}」
			</view>
			<view class="row" v-for="n in list" :key="n.city_id" @click="tap(n)">
				<text>{{ n.name }}</text>
				<text class="arrow" v-if="n.has_children">›</text>
			</view>
			<view class="empty" v-if="loaded && !list.length">{{ $t(`暂无可选区域`) }}</view>
		</view>
	</view>
</template>

<script>
	import colors from '@/mixins/color.js';
	import { getRegion, setRegion, buildRegion } from '@/utils/region.js';
	import { regionChildren, regionHot, regionLocate, regionInfo, clearCartAll } from '@/api/vn.js';

	export default {
		mixins: [colors],
		data() {
			return {
				current: getRegion(),
				hot: [],
				list: [],
				stack: [], // 已进入的层级 [{city_id,name}]
				loaded: false,
				locating: false,
				locateMsg: '',
				located: null
			};
		},
		onLoad() {
			regionHot().then((res) => {
				this.hot = res.data || [];
			}).catch(() => {});
			this.loadChildren(0, true);
		},
		methods: {
			// parent=0 为国家层；仅有一个国家时直接下钻
			loadChildren(parentId, auto) {
				regionChildren({ parent_id: parentId }).then((res) => {
					const rows = res.data || [];
					if (auto && parentId === 0 && rows.length === 1 && rows[0].has_children) {
						this.loadChildren(rows[0].city_id, false);
						return;
					}
					this.list = rows;
					this.loaded = true;
				}).catch(() => {
					this.loaded = true;
				});
			},
			tap(n) {
				if (n.has_children) {
					this.stack.push({ city_id: n.city_id, name: n.name });
					this.loadChildren(n.city_id, false);
				} else {
					this.pick(n.city_id);
				}
			},
			up(i) {
				this.stack = i < 0 ? [] : this.stack.slice(0, i + 1);
				this.loadChildren(i < 0 ? 0 : this.stack[i].city_id, i < 0);
			},
			chooseStackTop() {
				this.pick(this.stack[this.stack.length - 1].city_id);
			},
			pickHot(h) {
				this.pick(h.city_id);
			},
			// 定位：失败/拒绝不阻塞，用户仍可从热门/列表选择
			locate() {
				this.locating = true;
				this.locateMsg = '';
				this.located = null;
				uni.getLocation({
					type: 'wgs84',
					success: (loc) => {
						regionLocate({ lat: loc.latitude, lng: loc.longitude }).then((res) => {
							this.locating = false;
							if (res.data && res.data.matched) {
								this.located = res.data;
							} else {
								this.locateMsg = this.$t(`当前位置暂不在配送范围，请从下方选择`);
							}
						}).catch(() => {
							this.locating = false;
							this.locateMsg = this.$t(`定位失败，请从下方选择`);
						});
					},
					fail: () => {
						this.locating = false;
						this.locateMsg = this.$t(`无法获取位置，请从下方选择`);
					}
				});
			},
			pick(cityId) {
				regionInfo({ city_id: cityId }).then((res) => {
					if (res.data && res.data.valid) {
						this.choose(res.data.node, res.data.chain);
					} else {
						this.$util.Tips({ title: this.$t(`该区域暂未开放`) });
					}
				});
			},
			choose(node, chain) {
				const next = buildRegion(node, chain);
				const old = getRegion();
				if (old && old.city_id !== next.city_id) {
					// 切换区域需清空购物车（价格按区域计价）
					uni.showModal({
						title: this.$t(`提示`),
						content: this.$t(`切换配送区域将清空购物车，是否继续？`),
						success: (m) => {
							if (!m.confirm) return;
							clearCartAll().catch(() => {}).then(() => this.done(next));
						}
					});
				} else {
					this.done(next);
				}
			},
			done(region) {
				setRegion(region);
				uni.reLaunch({ url: '/pages/index/index' });
			}
		}
	};
</script>

<style lang="scss" scoped>
	.region-select {
		min-height: 100vh;
		background: #f5f5f5;
		padding: 20rpx;

		.locate-bar {
			background: #fff;
			border-radius: 16rpx;
			padding: 24rpx;
			margin-bottom: 20rpx;
		}

		.locate-btn {
			color: #e93323;
			font-size: 30rpx;
			font-weight: 600;
		}

		.locate-tip {
			margin-top: 12rpx;
			color: #999;
			font-size: 24rpx;
		}

		.locate-result {
			margin-top: 12rpx;
			color: #1aad19;
			font-size: 28rpx;
		}

		.section {
			background: #fff;
			border-radius: 16rpx;
			padding: 24rpx;
			margin-bottom: 20rpx;

			.title {
				font-weight: 700;
				margin-bottom: 16rpx;
			}
		}

		.grid {
			display: flex;
			flex-wrap: wrap;

			.cell {
				width: 30%;
				margin: 0 3% 16rpx 0;
				text-align: center;
				padding: 14rpx 0;
				background: #f5f5f5;
				border-radius: 8rpx;
				font-size: 26rpx;

				&.on {
					background: #e93323;
					color: #fff;
				}
			}
		}

		.crumbs {
			font-size: 24rpx;
			color: #888;
			margin-bottom: 8rpx;
		}

		.pick-here {
			color: #e93323;
			padding: 12rpx 0;
			border-bottom: 1px solid #eee;
		}

		.row {
			display: flex;
			justify-content: space-between;
			padding: 22rpx 0;
			border-bottom: 1px solid #eee;
			font-size: 28rpx;
		}

		.empty {
			text-align: center;
			color: #999;
			padding: 40rpx 0;
		}
	}
</style>
