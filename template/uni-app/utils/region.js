// 菜集鲜：配送区域本地缓存。结构 {city_id, name, chain:[{city_id,name}]}
const KEY = 'region';

export function getRegion() {
	try {
		const r = uni.getStorageSync(KEY);
		return r && r.city_id ? r : null;
	} catch (e) {
		return null;
	}
}

export function getRegionId() {
	const r = getRegion();
	return r ? r.city_id : 0;
}

export function setRegion(region) {
	uni.setStorageSync(KEY, region);
}

export function clearRegion() {
	try {
		uni.removeStorageSync(KEY);
	} catch (e) {}
}

// 由 region/info 或 region/locate 返回的 {node, chain} 构造缓存对象
export function buildRegion(node, chain) {
	return {
		city_id: node.city_id,
		name: node.name,
		chain: (chain || []).map((c) => ({
			city_id: c.city_id,
			name: c.name
		}))
	};
}

// 展示用短名：优先最细一级
export function regionShortName(region) {
	if (!region) return '';
	return region.name || '';
}

// 展示用全称：省 > 郡（去掉国家层）
export function regionFullName(region) {
	if (!region) return '';
	const names = (region.chain || []).filter((c, i) => i > 0).map((c) => c.name);
	return names.length ? names.join(' · ') : region.name;
}
