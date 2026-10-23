// 运行：node template/uni-app/tests/sw_test.js —— 用桩环境验证 Service Worker 的缓存路由决策
const fs = require('fs');
const path = require('path');
const src = fs.readFileSync(path.join(__dirname, '../static/pwa/sw.js'), 'utf8');
const listeners = {};
const store = {};          // cacheName -> {url: response}
const fetched = [];
let online = true;
const self_ = {
  location: { origin: 'https://shop.example.com' },
  addEventListener: (t, f) => (listeners[t] = f),
  skipWaiting: () => Promise.resolve(),
  clients: { claim: () => Promise.resolve() },
};
const caches_ = {
  open: async (n) => ({
    addAll: async (urls) => { store[n] = store[n] || {}; urls.forEach((u) => (store[n][u] = { url: u, status: 200, clone() { return this; } })); },
    put: async (req, res) => { store[n] = store[n] || {}; store[n][new URL(req.url).pathname] = res; },
  }),
  match: async (req) => {
    const key = typeof req === 'string' ? req : new URL(req.url).pathname;
    for (const n of Object.keys(store)) if (store[n][key]) return store[n][key];
    return undefined;
  },
  keys: async () => Object.keys(store),
  delete: async (k) => { delete store[k]; return true; },
};
const fetch_ = async (req) => { fetched.push(req.url); if (!online) throw new Error('offline'); return { status: 200, url: req.url, clone() { return this; } }; };
new Function('self', 'caches', 'fetch', 'URL', 'Promise', src)(self_, caches_, fetch_, URL, Promise);

let fail = 0, pass = 0;
const eq = (a, b, n) => { if (a === b) pass++; else { fail++; console.log('FAIL', n, a, b); } };
const ev = (url, method = 'GET', mode = 'cors') => {
  let responded = null;
  listeners.fetch({ request: { url, method, mode }, respondWith: (p) => (responded = p) });
  return responded;
};

(async () => {
  let waited; listeners.install({ waitUntil: (p) => (waited = p) }); await waited;
  eq(!!store['cjx-shell-v1']['/'], true, 'install precaches shell "/"');
  eq(ev('https://shop.example.com/api/products'), null, 'api not intercepted');
  eq(ev('https://shop.example.com/adminapi/order/list'), null, 'adminapi not intercepted');
  eq(ev('https://shop.example.com/uploads/a.png'), null, 'uploads not intercepted');
  eq(ev('https://cdn.other.com/static/x.js'), null, 'cross-origin not intercepted');
  eq(ev('https://shop.example.com/static/js/a.js', 'POST'), null, 'non-GET not intercepted');
  const r1 = ev('https://shop.example.com/static/js/app.123.js'); eq(r1 !== null, true, 'static asset handled');
  await r1; await new Promise((r) => setTimeout(r, 5));
  eq(!!store['cjx-shell-v1']['/static/js/app.123.js'], true, 'static asset cached after first fetch');
  fetched.length = 0;
  await ev('https://shop.example.com/static/js/app.123.js');
  eq(fetched.length, 0, 'second request served from cache (cache-first)');
  // 离线导航回退到壳
  online = false;
  const nav = await ev('https://shop.example.com/pages/goods/order_list', 'GET', 'navigate');
  eq(nav && nav.url, '/', 'offline navigation falls back to cached shell');
  // 升级清理
  store['old-cache'] = { '/x': {} };
  let act; listeners.activate({ waitUntil: (p) => (act = p) }); await act;
  eq(Object.keys(store).includes('old-cache'), false, 'old caches removed on activate');
  console.log(fail ? `FAILED ${fail} (passed ${pass})` : `OK ${pass} assertions`);
  process.exit(fail ? 1 : 0);
})();
