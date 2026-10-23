<template>
	<view class="region-picker">
		<picker :range="countryNames" :value="countryIndex" @change="onCountry" class="country">
			<view class="country-val">{{ currentCountryName }} <text class="arrow">▾</text></view>
		</picker>
		<picker mode="multiSelector" :range="columnNames" :value="indexes" @change="onConfirm" @columnchange="onColumn" class="levels">
			<view class="levels-val" :class="{ placeholder: !text }">{{ text || $t(`请选择所在地区`) }}</view>
		</picker>
	</view>
</template>

<script>
	import { regionAddressChildren } from '@/api/vn.js';

	// 地址用区域选择：国家 → 省 → 郡/县 → 坊/社（读取 region/address_children，所有 is_show 节点，不受配送白名单限制）
	export default {
		name: 'RegionPicker',
		props: {
			// 展示文本（编辑已有地址时传入）
			displayText: {
				type: String,
				default: ''
			}
		},
		data() {
			return {
				countries: [],
				countryIndex: 0,
				cols: [[], [], []], // 三列节点数组
				indexes: [0, 0, 0],
				text: this.displayText
			};
		},
		computed: {
			countryNames() {
				return this.countries.map((c) => c.name);
			},
			currentCountryName() {
				const c = this.countries[this.countryIndex];
				return c ? c.name : '';
			},
			columnNames() {
				return this.cols.map((col) => col.map((n) => n.name));
			}
		},
		watch: {
			displayText(v) {
				this.text = v;
			}
		},
		created() {
			regionAddressChildren({ parent_id: 0 }).then((res) => {
				this.countries = res.data || [];
				if (this.countries.length) this.loadColumn(0, this.countries[this.countryIndex].city_id, true);
			});
		},
		methods: {
			onCountry(e) {
				this.countryIndex = Number(e.detail.value);
				this.cols = [[], [], []];
				this.indexes = [0, 0, 0];
				this.text = '';
				this.$emit('change', null);
				this.loadColumn(0, this.countries[this.countryIndex].city_id, true);
			},
			// 加载第 level 列（其父为 parentId）；cascade=true 时继续加载下一列的首项
			loadColumn(level, parentId, cascade) {
				return regionAddressChildren({ parent_id: parentId }).then((res) => {
					const rows = res.data || [];
					this.$set(this.cols, level, rows);
					this.$set(this.indexes, level, 0);
					for (let l = level + 1; l < 3; l++) {
						this.$set(this.cols, l, []);
						this.$set(this.indexes, l, 0);
					}
					if (cascade && rows.length && level < 2) {
						return this.loadColumn(level + 1, rows[0].city_id, true);
					}
				});
			},
			onColumn(e) {
				const col = e.detail.column;
				const idx = e.detail.value;
				this.$set(this.indexes, col, idx);
				if (col < 2 && this.cols[col][idx]) {
					this.loadColumn(col + 1, this.cols[col][idx].city_id, true);
				}
			},
			onConfirm(e) {
				const v = e.detail.value;
				const picked = [];
				for (let l = 0; l < 3; l++) {
					const n = this.cols[l][v[l]];
					if (n) picked.push(n);
				}
				if (!picked.length) return;
				const last = picked[picked.length - 1];
				this.text = picked.map((n) => n.name).join(' · ');
				this.$emit('change', {
					city_id: last.city_id,
					names: picked.map((n) => n.name),
					country_code: last.country_code,
					text: this.text
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.region-picker {
		display: flex;
		flex-direction: column;
		width: 100%;

		.country-val {
			padding: 8rpx 0;
			color: #888;
			font-size: 26rpx;
		}

		.levels-val {
			padding: 8rpx 0;
			font-size: 28rpx;

			&.placeholder {
				color: #999;
			}
		}
	}
</style>
