<template>
  <div class="city-cascader" :style="{ width: width }">
    <el-cascader
      :key="panelKey"
      v-model="innerPath"
      :options="options"
      :props="cascaderProps"
      :placeholder="placeholder"
      :clearable="clearable"
      :disabled="disabled"
      :filterable="filterable"
      :show-all-levels="true"
      style="width: 100%"
      @change="onPathChange"
    />
    <div v-if="showMeta && meta.city_id" class="city-cascader__meta">
      <span>city_id={{ meta.city_id }}</span>
      <el-tag size="mini" type="info" class="ml6">{{ meta.level_label }} · L{{ meta.level }}</el-tag>
      <span v-if="meta.merger_name" class="city-cascader__name ml6">{{ meta.merger_name }}</span>
    </div>
  </div>
</template>

<script>
import { regionList, regionResolve } from '@/api/region';

const LEVEL_LABEL = { '-1': '国家', 0: '省', 1: '市/郡', 2: '区县/坊', 3: '更细' };

function levelLabel(level) {
  const k = String(level);
  return LEVEL_LABEL[k] || 'L' + level;
}

function mapNode(c) {
  return {
    city_id: c.city_id,
    name: c.name,
    level: c.level,
    merger_name: c.merger_name,
    leaf: !c.has_children,
  };
}

/**
 * 管理端区划级联：自由颗粒度（国家/省/市郡/区县坊任一级可选），v-model 为 city_id。
 * 已有 city_id 时通过 resolve 反显路径与颗粒度。
 */
export default {
  name: 'CityCascader',
  props: {
    value: { type: [Number, String], default: '' },
    placeholder: { type: String, default: '选择区划（任一级可点选）' },
    clearable: { type: Boolean, default: true },
    disabled: { type: Boolean, default: false },
    filterable: { type: Boolean, default: true },
    showMeta: { type: Boolean, default: true },
    width: { type: String, default: '100%' },
  },
  data() {
    return {
      panelKey: 0,
      innerPath: [],
      options: [],
      useLazy: true,
      meta: {},
      syncing: false,
      hydrateToken: 0,
    };
  },
  computed: {
    cascaderProps() {
      const self = this;
      const base = {
        checkStrictly: true,
        value: 'city_id',
        label: 'name',
        leaf: 'leaf',
        children: 'children',
        emitPath: true,
      };
      if (!this.useLazy) {
        return base;
      }
      return {
        ...base,
        lazy: true,
        lazyLoad(node, resolve) {
          const pid = node.level === 0 ? 0 : node.value;
          regionList({ parent_id: pid, limit: 500 })
            .then((res) => resolve((res.data.list || []).map(mapNode)))
            .catch(() => resolve([]));
        },
      };
    },
  },
  watch: {
    value: {
      immediate: true,
      handler(v) {
        const id = v === '' || v === null || v === undefined ? 0 : Number(v);
        const cur = this.meta.city_id ? Number(this.meta.city_id) : 0;
        const pathLast = this.innerPath.length ? Number(this.innerPath[this.innerPath.length - 1]) : 0;
        if (id === cur && id === pathLast) return;
        if (id === pathLast && id > 0 && this.meta.city_id) return;
        this.hydrate(id);
      },
    },
  },
  methods: {
    async hydrate(cityId) {
      const token = ++this.hydrateToken;
      this.syncing = true;
      if (!cityId) {
        this.meta = {};
        this.innerPath = [];
        this.options = [];
        this.useLazy = true;
        this.panelKey += 1;
        this.syncing = false;
        return;
      }
      try {
        const res = await regionResolve({ city_id: cityId });
        if (token !== this.hydrateToken) return;
        const d = res.data || {};
        this.meta = {
          city_id: d.city_id,
          name: d.name,
          level: d.level,
          level_label: d.level_label || levelLabel(d.level),
          merger_name: d.merger_name || (d.path_names || []).join(','),
          path_ids: d.path_ids || [],
          path_names: d.path_names || [],
        };
        const pathIds = (d.path_ids || []).map(Number);
        this.options = await this.buildPathOptions(pathIds);
        if (token !== this.hydrateToken) return;
        this.useLazy = false;
        this.innerPath = pathIds;
        this.panelKey += 1;
      } catch (e) {
        if (token !== this.hydrateToken) return;
        this.meta = { city_id: cityId, level: '', level_label: '未知', merger_name: '' };
        this.innerPath = [];
        this.options = [];
        this.useLazy = true;
        this.panelKey += 1;
      } finally {
        if (token === this.hydrateToken) this.syncing = false;
      }
    },
    async buildPathOptions(pathIds) {
      const rootRes = await regionList({ parent_id: 0, limit: 500 });
      const roots = (rootRes.data.list || []).map(mapNode);
      let levelNodes = roots;
      for (let i = 0; i < pathIds.length; i++) {
        const id = pathIds[i];
        const node = levelNodes.find((n) => Number(n.city_id) === Number(id));
        if (!node) break;
        if (node.leaf) break;
        const kidRes = await regionList({ parent_id: id, limit: 500 });
        const kids = (kidRes.data.list || []).map(mapNode);
        this.$set(node, 'children', kids);
        levelNodes = kids;
      }
      return roots;
    },
    onPathChange(path) {
      if (this.syncing) return;
      if (!path || !path.length) {
        this.meta = {};
        this.innerPath = [];
        this.options = [];
        this.useLazy = true;
        this.panelKey += 1;
        this.$emit('input', '');
        this.$emit('change', null);
        return;
      }
      const cityId = Number(path[path.length - 1]);
      // 静态树上取节点信息；懒加载时回落 resolve
      const nodeMeta = this.findInOptions(this.options, cityId);
      if (nodeMeta) {
        this.applyMeta({
          city_id: cityId,
          name: nodeMeta.name,
          level: nodeMeta.level,
          level_label: levelLabel(nodeMeta.level),
          merger_name: nodeMeta.merger_name || '',
          path_ids: path.map(Number),
          path_names: [],
        });
        this.$emit('input', cityId);
        this.$emit('change', { ...this.meta });
        return;
      }
      regionResolve({ city_id: cityId })
        .then((res) => {
          const d = res.data || {};
          this.applyMeta(d);
          this.$emit('input', cityId);
          this.$emit('change', { ...this.meta });
        })
        .catch(() => {
          this.applyMeta({ city_id: cityId, level: '', level_label: '', merger_name: '', path_ids: path.map(Number) });
          this.$emit('input', cityId);
          this.$emit('change', { ...this.meta });
        });
    },
    applyMeta(d) {
      this.meta = {
        city_id: d.city_id,
        name: d.name || '',
        level: d.level,
        level_label: d.level_label || levelLabel(d.level),
        merger_name: d.merger_name || (d.path_names || []).join(',') || '',
        path_ids: d.path_ids || [],
        path_names: d.path_names || [],
      };
    },
    findInOptions(list, cityId) {
      if (!list || !list.length) return null;
      for (const n of list) {
        if (Number(n.city_id) === Number(cityId)) return n;
        const hit = this.findInOptions(n.children || [], cityId);
        if (hit) return hit;
      }
      return null;
    },
  },
};
</script>

<style scoped>
.city-cascader__meta {
  margin-top: 4px;
  font-size: 12px;
  color: #909399;
  line-height: 1.4;
}
.city-cascader__name {
  color: #606266;
}
.ml6 {
  margin-left: 6px;
}
</style>
