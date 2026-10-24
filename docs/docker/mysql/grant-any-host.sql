-- 已有数据卷（init 不会再跑）时手动执行，修复 1045 / caching_sha2 兼容问题：
--   docker exec -i cjx-mysql mysql -uroot -proot < docs/docker/mysql/grant-any-host.sql
-- 或：
--   docker compose -f docs/docker/docker-compose.yml exec -T mysql mysql -uroot -proot < docs/docker/mysql/grant-any-host.sql

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';

CREATE USER IF NOT EXISTS 'crmeb'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
CREATE USER IF NOT EXISTS 'crmeb'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `crmeb`.* TO 'crmeb'@'%';
GRANT ALL PRIVILEGES ON `crmeb`.* TO 'crmeb'@'localhost';

FLUSH PRIVILEGES;

SELECT user, host, plugin FROM mysql.user WHERE user IN ('root', 'crmeb') ORDER BY user, host;
