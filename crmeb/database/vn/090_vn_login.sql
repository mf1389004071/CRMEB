-- M9-1 登录/注册区号：eb_user.phone_country_code。幂等（依赖 000_helpers.sql）。
-- 回滚：ALTER TABLE eb_user DROP COLUMN phone_country_code;
SET NAMES utf8mb4;
CALL eb_vn_add_column('eb_user', 'phone_country_code', "varchar(8) NOT NULL DEFAULT '' COMMENT '登录账号手机区号，如+84'");

-- M9-2 后台重置用户密码：接口权限（挂在用户管理接口分组 pid=2475 下）
INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 2475, '', '重置用户密码', 'admin', '', '', 'user/user/reset_password/<uid>', 'POST', '[]', 0, 1, 0, 1, '', '', 2, '', 0, 'user-user-reset_password', 0, ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'user-user-reset_password');
