-- M5-2 内容多语：eb_i18n_content（商品/分类/规格/区划等字段译文）与 eb_i18n_glossary（术语表）。幂等。
-- 约定：主表字段保存站点默认语言(vi-VN)内容；译文行仅在需要覆盖/补充时存在；回落链：当前语 → i18n_fallback_lang → 主表字段。
-- status：0=机翻待审，1=已审核/人工填写。
-- 回滚：DROP TABLE eb_i18n_content; DROP TABLE eb_i18n_glossary;
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `eb_i18n_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'product|category|product_attr|sku|city|…',
  `entity_id` int(11) NOT NULL DEFAULT 0,
  `field` varchar(32) NOT NULL DEFAULT '',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT 'zh-CN|vi-VN|en-US',
  `value` mediumtext COMMENT '译文',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0机翻待审 1已审核/人工',
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_entity_field_lang` (`entity_type`, `entity_id`, `field`, `lang`),
  KEY `idx_e` (`entity_type`, `entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='内容多语';

CREATE TABLE IF NOT EXISTS `eb_i18n_glossary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zh` varchar(100) NOT NULL DEFAULT '',
  `vi` varchar(100) NOT NULL DEFAULT '',
  `en` varchar(100) NOT NULL DEFAULT '',
  `remark` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_zh` (`zh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='多语术语表(机翻用)';
