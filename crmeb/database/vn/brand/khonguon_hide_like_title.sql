-- 隐藏「猜你喜欢」文案：语言包对齐为「推荐」的多语译文（幂等）
SET NAMES utf8mb4;

-- 核心三语强制
UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.is_del=0
SET c.lang_explain = CASE t.file_name
    WHEN 'zh-CN' THEN '推荐'
    WHEN 'vi-VN' THEN 'Đề xuất'
    WHEN 'en-US' THEN 'Recommended'
    ELSE c.lang_explain END,
    c.remarks = '已隐藏，统一为推荐'
WHERE c.code='猜你喜欢' AND c.is_admin=0
  AND t.file_name IN ('zh-CN','vi-VN','en-US');

-- 其余语言：猜你喜欢 跟 推荐 同译文
UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.is_del=0
JOIN eb_lang_code r ON r.code='推荐' AND r.is_admin=0 AND r.type_id=c.type_id
SET c.lang_explain=r.lang_explain, c.remarks='已隐藏，统一为推荐'
WHERE c.code='猜你喜欢' AND c.is_admin=0
  AND t.file_name NOT IN ('zh-CN','vi-VN','en-US');

-- 推荐核心三语校正（区块标题）
UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.is_del=0
SET c.lang_explain = CASE t.file_name
    WHEN 'zh-CN' THEN '推荐'
    WHEN 'vi-VN' THEN 'Đề xuất'
    WHEN 'en-US' THEN 'Recommended'
    ELSE c.lang_explain END
WHERE c.code='推荐' AND c.is_admin=0
  AND t.file_name IN ('zh-CN','vi-VN','en-US');
