-- M10-4 联系方式组合数据 vn_contact（后台“组合数据”页可维护）。幂等。
-- 字段：type(zalo/wechat/phone/email/facebook)、account、qrcode_url(上传图片)、sort、status 由组合数据通用字段承担
-- 回滚：DELETE FROM eb_system_group_data WHERE gid=(SELECT id FROM eb_system_group WHERE config_name='vn_contact');
--       DELETE FROM eb_system_group WHERE config_name='vn_contact';
SET NAMES utf8mb4;
INSERT INTO eb_system_group (cate_id, name, info, config_name, fields)
SELECT 0, '联系方式', '站点联系方式(Zalo/微信/电话/邮箱/Facebook)，未配置的类型前台不显示', 'vn_contact',
 '[{"name":"类型","title":"type","type":"select","param":"zalo=>Zalo\nwechat=>微信\nphone=>电话\nemail=>邮箱\nfacebook=>Facebook"},{"name":"账号/号码","title":"account","type":"input","param":""},{"name":"二维码(上传图片)","title":"qrcode_url","type":"upload","param":""}]'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_group WHERE config_name = 'vn_contact');
