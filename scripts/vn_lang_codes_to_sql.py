#!/usr/bin/env python3
"""M0-3：把 crmeb/database/vn/lang_codes.tsv 生成 crmeb/database/vn/900_lang_codes.sql（幂等）。

TSV 列（Tab 分隔，# 开头为注释）：scope \t zh \t vi \t en
  scope = api   接口 msg（is_admin=1，code 为 vn_<md5前10位>，getLang 以中文 remarks 反查）
        = front 前端 $t(key)（is_admin=0，code=中文原文，沿用现有约定）
用法：python scripts/vn_lang_codes_to_sql.py
"""
import hashlib, os, sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'crmeb', 'database', 'vn')
SRC = os.path.join(ROOT, 'lang_codes.tsv')
DST = os.path.join(ROOT, '900_lang_codes.sql')


def q(s):
    bs = chr(92)
    return "'" + s.replace(bs, bs + bs).replace("'", "''") + "'"


def main():
    rows = []
    seen = set()
    for n, line in enumerate(open(SRC, encoding='utf-8'), 1):
        line = line.rstrip('\r\n')
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        p = line.split('\t')
        if len(p) != 4 or p[0] not in ('api', 'front') or not all(p[1:]):
            sys.exit('lang_codes.tsv 第 %d 行格式错误: %r' % (n, line))
        if (p[0], p[1]) in seen:
            sys.exit('重复词条 第 %d 行: %r' % (n, p[1]))
        seen.add((p[0], p[1]))
        rows.append(p)
    out = ['-- 由 scripts/vn_lang_codes_to_sql.py 自动生成，请勿手改；幂等。',
           '-- 回滚：DELETE FROM eb_lang_code WHERE code LIKE vn_%（api 词条）；front 词条按中文 code 删除。',
           'SET NAMES utf8mb4;',
           "SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);",
           "SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);",
           "SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);", '']
    out.append('INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)')
    out.append('SELECT v.tid, v.code, v.remarks, v.explain_, v.is_admin FROM (')
    parts = []
    for scope, zh, vi, en in rows:
        code = 'vn_' + hashlib.md5(zh.encode('utf-8')).hexdigest()[:10] if scope == 'api' else zh
        adm = 1 if scope == 'api' else 0
        for tid, rem, txt in (('@t_zh', zh, zh), ('@t_vi', '[待审]' + zh, vi), ('@t_en', zh, en)):
            parts.append('  SELECT %s AS tid, %s AS code, %s AS remarks, %s AS explain_, %d AS is_admin'
                         % (tid, q(code), q(rem), q(txt), adm))
    if not parts:
        out = out[:-2] + ['-- 暂无词条']
    else:
        out.append('\n  UNION ALL\n'.join(parts))
        out.append(') v')
        out.append('WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code);')
    out += ['', '-- 使语言包缓存失效：执行后在后台“清除缓存”', '']
    open(DST, 'w', encoding='utf-8', newline='\n').write('\n'.join(out))
    print('生成 %d 条词条 -> %s' % (len(rows), os.path.normpath(DST)))


if __name__ == '__main__':
    main()
