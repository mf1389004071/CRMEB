# 菜集鲜本地开发 PHP 镜像（重建当前本机使用的 dev-php74）
# 构建：在仓库根目录执行
#   docker build -t dev-php74 -f docs/docker/dev-php74.Dockerfile .
FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
        git zip unzip curl \
        libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
        libzip-dev libonig-dev libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql mysqli gd zip bcmath mbstring

RUN pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable opcache

# 本地开发默认开启 OPcache（可用 compose 挂载覆盖）
COPY docs/docker/php/opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN curl -sS https://getcomposer.org/installer | php -- \
        --version=2.0.14 \
        --install-dir=/usr/local/bin \
        --filename=composer

WORKDIR /var/www/html
CMD ["php-fpm", "-F"]
