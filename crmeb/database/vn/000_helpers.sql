-- 通用幂等助手：eb_vn_add_column(表, 列, 列定义) / eb_vn_add_index(表, 索引名, 索引定义)
-- 回滚：DROP PROCEDURE eb_vn_add_column; DROP PROCEDURE eb_vn_add_index;
DROP PROCEDURE IF EXISTS eb_vn_add_column;
DROP PROCEDURE IF EXISTS eb_vn_add_index;
DELIMITER $$
CREATE PROCEDURE eb_vn_add_column(IN t VARCHAR(64), IN c VARCHAR(64), IN def VARCHAR(500))
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = t AND COLUMN_NAME = c) THEN
    SET @s = CONCAT('ALTER TABLE `', t, '` ADD COLUMN `', c, '` ', def);
    PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
  END IF;
END$$
CREATE PROCEDURE eb_vn_add_index(IN t VARCHAR(64), IN idx VARCHAR(64), IN def VARCHAR(500))
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = t AND INDEX_NAME = idx) THEN
    SET @s = CONCAT('ALTER TABLE `', t, '` ADD ', def);
    PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
  END IF;
END$$
DELIMITER ;
