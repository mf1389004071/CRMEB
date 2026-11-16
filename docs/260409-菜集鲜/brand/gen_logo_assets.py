# -*- coding: utf-8 -*-
"""从 docs/260409-菜集鲜/logo.jpg 生成各端 logo/favicon/PWA 资源。"""
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[3]
SRC = ROOT / "docs" / "260409-菜集鲜" / "logo.jpg"


def save_rgb(img: Image.Image, path: Path, size=None, bg=(255, 255, 255)):
    im = img.copy()
    if size:
        im = im.resize(size, Image.Resampling.LANCZOS)
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.suffix.lower() in (".jpg", ".jpeg"):
        rgb = Image.new("RGB", im.size, bg)
        rgb.paste(im, mask=im.split()[-1] if im.mode == "RGBA" else None)
        rgb.save(path, quality=92)
    else:
        im.save(path)


def main():
    img = Image.open(SRC).convert("RGBA")
    sysdir = ROOT / "crmeb" / "public" / "statics" / "system_images"
    save_rgb(img, sysdir / "admin_logo_big.png", (240, 64))
    save_rgb(img, sysdir / "admin_logo_small.png", (64, 64))
    save_rgb(img, sysdir / "admin_login_logo.png", (220, 72))
    save_rgb(img, sysdir / "login_logo.jpeg", (220, 72))
    save_rgb(img, sysdir / "pc_logo.png", (220, 64))
    save_rgb(img, sysdir / "share_image.jpeg", (300, 300))

    brand = ROOT / "crmeb" / "public" / "statics" / "brand"
    save_rgb(img, brand / "khonguon-logo.png", (512, 512))
    save_rgb(img, brand / "khonguon-logo.jpg", (512, 512))

    admin_assets = ROOT / "template" / "admin" / "src" / "assets" / "images"
    for name, size in [
        ("logo.png", (220, 72)),
        ("logo-dark.png", (220, 72)),
        ("logo-small.png", (64, 64)),
        ("logo.jpg", (220, 72)),
        ("logo-min.jpg", (64, 64)),
    ]:
        save_rgb(img, admin_assets / name, size)

    ico = img.copy().resize((32, 32), Image.Resampling.LANCZOS)
    for p in [
        ROOT / "template" / "admin" / "public" / "favicon.ico",
        ROOT / "crmeb" / "public" / "admin" / "favicon.ico",
        # H5/站点根路径浏览器默认请求 /favicon.ico（管理端用 /admin/favicon.ico）
        ROOT / "crmeb" / "public" / "favicon.ico",
    ]:
        p.parent.mkdir(parents=True, exist_ok=True)
        ico.save(p, format="ICO", sizes=[(32, 32)])

    for d in [
        ROOT / "template" / "uni-app" / "static" / "pwa",
        ROOT / "crmeb" / "public" / "static" / "pwa",
    ]:
        save_rgb(img, d / "icon-192.png", (192, 192))
        save_rgb(img, d / "icon-512.png", (512, 512))
        save_rgb(img, d / "icon-512-maskable.png", (512, 512))
        save_rgb(img, d / "apple-touch-icon.png", (180, 180))

    # 找回密码等页硬编码的旧 crmeb logo2
    for p in [
        ROOT / "template" / "uni-app" / "pages" / "users" / "static" / "logo2.png",
        ROOT / "crmeb" / "public" / "pages" / "users" / "static" / "logo2.png",
        ROOT / "crmeb" / "public" / "statics" / "mp_view" / "pages" / "users" / "static" / "logo2.png",
    ]:
        save_rgb(img, p, (192, 192))

    print("logo assets generated")


if __name__ == "__main__":
    main()
