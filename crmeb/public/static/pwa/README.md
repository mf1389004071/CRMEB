# 菜集鲜 H5 PWA（M11）

- `manifest.webmanifest`：Web App Manifest（standalone，主题色 `#2e9e4b`，192/512/maskable 图标）。
- `sw.js`：极简 Service Worker，**只缓存静态壳**，不缓存任何 API。
- 入口：`template/uni-app/index.html`（H5 自定义模板）引入 manifest、iOS `apple-touch-icon` 与 meta，并注册 SW。

## 部署要求
1. 必须 **HTTPS**（localhost 除外）；
2. SW 位于 `/static/pwa/sw.js`，要控制整站需响应头 `Service-Worker-Allowed: /`，Nginx 示例：
```nginx
location = /static/pwa/sw.js {
    add_header Service-Worker-Allowed "/";
    add_header Cache-Control "no-cache";
}
```
3. 验证：Android Chrome 打开站点 → 菜单“安装应用/添加到主屏幕”；DevTools → Application → Manifest 无报错、Service Workers 为 activated。
4. 升级静态壳：修改 `sw.js` 里的 `VERSION`。
