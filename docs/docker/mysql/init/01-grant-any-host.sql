-- 仅在数据目录首次初始化时由官方 mysql 镜像自动执行。
-- 目标：任意来源（宿主机 / 同网络容器 / bridge IP）可用 root/root 或 crmeb/root 连接 crmeb 库。

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';

CREATE USER IF NOT EXISTS 'crmeb'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
CREATE USER IF NOT EXISTS 'crmeb'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `crmeb`.* TO 'crmeb'@'%';
GRANT ALL PRIVILEGES ON `crmeb`.* TO 'crmeb'@'localhost';

FLUSH PRIVILEGES;
