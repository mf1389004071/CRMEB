#!/bin/bash
# 运行全部 vn 测试：bash crmeb/tests/vn/run_all.sh   （需 docker：测试库 cjx-mysql、HTTP 服务 cjx-php，见 database/vn/README.md）
cd "$(dirname "$0")/../.."
fail=0
for f in tests/vn/*_test.php; do
  out=$(bash tests/vn/run.sh "$f" 2>&1 | tail -3)
  if echo "$out" | grep -q "^OK"; then echo "PASS $f: $(echo "$out" | grep '^OK')"; else echo "FAIL $f"; echo "$out"; fail=1; fi
done
# 前端纯函数测试（需 node）
if command -v node >/dev/null 2>&1; then
  out=$(node ../template/uni-app/tests/money_test.js 2>&1 | tail -3)
  if echo "$out" | grep -q "^OK"; then echo "PASS template/uni-app/tests/money_test.js: $out"; else echo "FAIL money_test.js"; echo "$out"; fail=1; fi
fi
exit $fail
