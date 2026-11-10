-- Kho Nguon：保留近期生鲜商品，清理数码演示分类/旧品（幂等）
-- 保留：id IN (5,6,7,8) 或 CSV 样例 886002-886099
SET NAMES utf8mb4;

-- 1) 确保生鲜分类可用
UPDATE eb_store_category
SET cate_name='Rau củ', pid=0, is_show=1, sort=100
WHERE id=41;

INSERT INTO eb_store_category (id, pid, cate_name, sort, pic, is_show, add_time, big_pic)
SELECT 41, 0, 'Rau củ', 100, '', 1, UNIX_TIMESTAMP(), ''
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_store_category WHERE id=41);

-- 2) 隐藏全部非生鲜分类
UPDATE eb_store_category
SET is_show=0
WHERE id <> 41;

-- 3) 修正保留商品挂载
UPDATE eb_store_product
SET cate_id='41', is_fresh=1, is_show=1, is_del=0
WHERE id IN (5,6,7,8) OR (id BETWEEN 886002 AND 886099);

DELETE c FROM eb_store_product_cate c
INNER JOIN eb_store_product p ON p.id=c.product_id
WHERE (p.id IN (5,6,7,8) OR (p.id BETWEEN 886002 AND 886099))
  AND c.cate_id <> 41;

INSERT INTO eb_store_product_cate (product_id, cate_id, cate_pid, status, add_time)
SELECT p.id, 41, 0, 1, UNIX_TIMESTAMP()
FROM eb_store_product p
WHERE (p.id IN (5,6,7,8) OR (p.id BETWEEN 886002 AND 886099))
  AND NOT EXISTS (
    SELECT 1 FROM eb_store_product_cate c WHERE c.product_id=p.id AND c.cate_id=41
  );

-- 4) 下架非保留商品
UPDATE eb_store_product
SET is_show=0, is_del=1
WHERE NOT (id IN (5,6,7,8) OR (id BETWEEN 886002 AND 886099))
  AND is_del=0;

-- 5) 清理非保留商品区域价
DELETE FROM eb_store_product_region_price
WHERE product_id NOT IN (
  SELECT id FROM (
    SELECT id FROM eb_store_product
    WHERE id IN (5,6,7,8) OR (id BETWEEN 886002 AND 886099)
  ) t
);
