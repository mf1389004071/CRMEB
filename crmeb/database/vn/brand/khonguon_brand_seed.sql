-- Kho Nguon | 源仓 品牌种子（幂等，可重复执行）
-- 用途：合同后站点品牌/联系方式/关于我们初始化；同分支项目可复制改值。
SET NAMES utf8mb4;

-- 站点基础
UPDATE eb_system_config SET value='"Kho Nguon | 源仓"' WHERE menu_name='site_name';
UPDATE eb_system_config SET value='"https:\\/\\/khonguon.alphavn.shop"' WHERE menu_name='site_url';
UPDATE eb_system_config SET value='"+84 988 619 355"' WHERE menu_name='contact_number';
UPDATE eb_system_config SET value='"+84 988 619 355"' WHERE menu_name='customer_phone';
UPDATE eb_system_config SET value='"136 nguyễn duy hiệu, p.hạc thành - thanh hoá"' WHERE menu_name='company_address';
UPDATE eb_system_config SET value='"Copyright © Kho Nguon | 源仓. All rights reserved."' WHERE menu_name='nncnL_crmeb_copyright';
UPDATE eb_system_config SET value='""' WHERE menu_name='nncnL_crmeb_copyright_image';
UPDATE eb_system_config SET value='"Kho Nguon | 源仓"' WHERE menu_name='wechat_share_title';
UPDATE eb_system_config SET value='""' WHERE menu_name='record_No';
UPDATE eb_system_config SET value='""' WHERE menu_name='icp_url';
UPDATE eb_system_config SET value='""' WHERE menu_name='network_security';
UPDATE eb_system_config SET value='""' WHERE menu_name='network_security_url';

-- Logo（覆盖 system_images 后保持默认路径即可）
UPDATE eb_system_config SET value='"/statics/system_images/admin_logo_big.png"' WHERE menu_name='site_logo';
UPDATE eb_system_config SET value='"/statics/system_images/admin_logo_small.png"' WHERE menu_name='site_logo_square';
UPDATE eb_system_config SET value='"/statics/system_images/admin_login_logo.png"' WHERE menu_name='login_logo';
UPDATE eb_system_config SET value='"/statics/system_images/login_logo.jpeg"' WHERE menu_name='wap_login_logo';
UPDATE eb_system_config SET value='"/statics/system_images/pc_logo.png"' WHERE menu_name='pc_logo';
UPDATE eb_system_config SET value='"/statics/system_images/share_image.jpeg"' WHERE menu_name='wechat_share_img';

-- 保持 VN 业务开关；官方门店自提关闭（走提货仓）
UPDATE eb_system_config SET value='"1"' WHERE menu_name='vn_mode_enable';
UPDATE eb_system_config SET value='"1"' WHERE menu_name='region_pricing_enable';
UPDATE eb_system_config SET value='"0"' WHERE menu_name='store_self_mention';

-- vn_contact：电话 + 邮箱（先清演示再插入）
SET @gid := (SELECT id FROM eb_system_group WHERE config_name='vn_contact' LIMIT 1);
DELETE FROM eb_system_group_data WHERE gid=@gid;
INSERT INTO eb_system_group_data (gid, value, add_time, sort, status)
SELECT @gid, '{"type":{"type":"select","value":"phone"},"account":{"type":"input","value":"+84 988 619 355"},"qrcode_url":{"type":"upload","value":""}}', UNIX_TIMESTAMP(), 1, 1
FROM DUAL WHERE @gid IS NOT NULL;
INSERT INTO eb_system_group_data (gid, value, add_time, sort, status)
SELECT @gid, '{"type":{"type":"select","value":"email"},"account":{"type":"input","value":"s0969980920@gmail.com"},"qrcode_url":{"type":"upload","value":""}}', UNIX_TIMESTAMP(), 2, 1
FROM DUAL WHERE @gid IS NOT NULL;

-- 关于我们
UPDATE eb_agreement
SET title='关于我们',
    content=CONCAT(
      '<h1><b>Kho Nguon | 源仓</b></h1>',
      '<p>KHO.NGUON 是面向商户的 B2B 生鲜供货平台。客户可按城市查看商品与区域价，下单后到对应城市仓库自提。</p>',
      '<p><b>联系电话：</b>+84 988 619 355</p>',
      '<p><b>邮箱：</b>s0969980920@gmail.com</p>',
      '<p><b>联系人：</b>石雄飞 / NGUYỄN THỊ NHÂN / TRƯƠNG THỊ THU HIỀN</p>',
      '<p><b>清化仓库：</b>136 nguyễn duy hiệu, p.hạc thành - thanh hoá</p>',
      '<p><b>官网：</b>https://khonguon.alphavn.shop/</p>'
    )
WHERE type=7;
