/* 菜集鲜 PWA 极简 Service Worker（M11）
 * 只缓存“静态壳”：首页 HTML 与 /static/ 下带 hash 的静态资源；
 * 绝不缓存 API（/api/、/adminapi/）及任何跨域请求，避免价格/库存/订单陈旧。
 * 升级：修改 VERSION 即可淘汰旧缓存。
 */
var VERSION = 'cjx-shell-v1';
var SHELL = ['/'];

self.addEventListener('install', function (e) {
  e.waitUntil(caches.open(VERSION).then(function (c) { return c.addAll(SHELL); }).then(function () { return self.skipWaiting(); }));
});

self.addEventListener('activate', function (e) {
  e.waitUntil(
    caches.keys().then(function (keys) {
      return Promise.all(keys.filter(function (k) { return k !== VERSION; }).map(function (k) { return caches.delete(k); }));
    }).then(function () { return self.clients.claim(); })
  );
});

self.addEventListener('fetch', function (e) {
  var req = e.request;
  if (req.method !== 'GET') return;
  var url = new URL(req.url);
  if (url.origin !== self.location.origin) return;                    // 跨域不管
  if (/^\/(api|adminapi|uploads|statics)\//.test(url.pathname)) return; // API/上传资源不走缓存

  // 页面导航：网络优先，失败回退缓存的壳（离线时至少能打开应用外壳）
  if (req.mode === 'navigate') {
    e.respondWith(fetch(req).catch(function () { return caches.match('/'); }));
    return;
  }
  // 静态资源（/static/ 下带 hash 文件）：缓存优先
  if (/^\/static\//.test(url.pathname)) {
    e.respondWith(
      caches.match(req).then(function (hit) {
        return hit || fetch(req).then(function (res) {
          if (res && res.status === 200) {
            var copy = res.clone();
            caches.open(VERSION).then(function (c) { c.put(req, copy); });
          }
          return res;
        });
      })
    );
  }
});
