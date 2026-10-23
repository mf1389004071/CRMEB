#!/bin/bash
# 用法: bash crmeb/tests/vn/run.sh tests/vn/xxx_test.php  （需本机 docker、镜像 dev-php74、测试库 cjx-mysql:33060）
cd "$(dirname "$0")/../.."
MSYS_NO_PATHCONV=1 docker run --rm --add-host=host.docker.internal:host-gateway \
  -e DATABASE_HOSTNAME=host.docker.internal -e DATABASE_HOSTPORT=33060 -e DATABASE_DATABASE=crmeb \
  -e DATABASE_USERNAME=root -e DATABASE_PASSWORD=root -e DATABASE_CHARSET=utf8mb4 \
  -v "$(pwd -W 2>/dev/null || pwd):/app" -w /app dev-php74 php "$@"
