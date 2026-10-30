-- 菜集鲜：VND 千分位改为逗号（与超市小票/收银常见写法一致；已装库幂等更新）
-- 回滚：UPDATE eb_system_currency SET thousand_sep='.', decimal_sep=',' WHERE code='VND';
SET NAMES utf8mb4;

UPDATE `eb_system_currency`
SET `thousand_sep` = ',',
    `decimal_sep` = '.',
    `update_time` = UNIX_TIMESTAMP()
WHERE `code` = 'VND'
  AND (`thousand_sep` <> ',' OR `decimal_sep` <> '.');
