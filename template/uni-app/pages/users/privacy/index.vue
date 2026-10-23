<template>
	<view class="content">
		<jyf-parser :html="content" ref="article" :tag-style="tagStyle"></jyf-parser>
	</view>
</template>

<script>
	import parser from "@/components/jyf-parser/jyf-parser";
	import {
		getUserAgreement,
	} from '@/api/user.js';
	import { normalizeLang } from '@/utils/lang.js';
	export default {
		components: {
			"jyf-parser": parser
		},
		data() {
			return {
				tagStyle: {
					img: 'width:100%;display:block;',
					table: 'width:100%',
					video: 'width:100%'
				},
				content: ``
			}
		},
		onLoad(options) {
			// VN: 越南模式使用静态多语协议 static/agreements/{locale}/{user|privacy}.html（客户提供正式文本后替换文件）
			if (this.vnMode) {
				const file = options.type == 3 ? 'privacy' : 'user';
				const locale = normalizeLang(this.$i18n.locale) || 'vi-VN';
				uni.request({
					url: `/static/agreements/${locale}/${file}.html`,
					success: (r) => {
						let html = typeof r.data === 'string' ? r.data : '';
						const m = html.match(/<!--\s*title:\s*(.*?)\s*-->/);
						if (m) uni.setNavigationBarTitle({ title: m[1] });
						this.content = html.replace(/<!--[\s\S]*?-->/, '');
					}
				});
				return;
			}
			getUserAgreement(options.type).then(res => {
				this.content = res.data.content
				uni.setNavigationBarTitle({
					title: res.data.title
				});
			}).catch(err => {
				that.$util.Tips({
					title: err
				});
			})
		}
		
	}
</script>

<style scoped>
	page {
		background-color: #fff;
	}

	.content {
		padding: 40rpx 30rpx;
		line-height: 2;
	}
</style>
