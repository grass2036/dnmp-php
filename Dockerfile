# 使用最新的 PHP 8.2 FPM Alpine 镜像作为基础镜像
FROM php:8.2-fpm-alpine

# 设置维护者信息
LABEL maintainer=""

# 设置时区环境变量
ENV TIMEZONE=Asia/Shanghai

# 设置工作目录
WORKDIR /var/www/html

# 安装系统依赖、PHP 扩展、Nginx 和 Composer，并安装 vim
RUN apk add --no-cache tzdata nginx supervisor curl vim \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && apk del tzdata \
    && apk add --no-cache $PHPIZE_DEPS \
        libzip-dev \
        libpng-dev \
        jpeg-dev \
        freetype-dev \
        postgresql-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        pdo_pgsql \
        opcache \
        zip \
        gd \
        bcmath \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# 配置 PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/' "$PHP_INI_DIR/php.ini" \
    && sed -i 's/post_max_size = 8M/post_max_size = 20M/' "$PHP_INI_DIR/php.ini" \
    && sed -i 's/memory_limit = 128M/memory_limit = 256M/' "$PHP_INI_DIR/php.ini"

# 创建一个非 root 用户
RUN addgroup -g 1000 appgroup \
    && adduser -u 1000 -G appgroup -s /bin/sh -D appuser

# 将工作目录的所有权更改为非 root 用户
RUN chown -R appuser:appgroup /var/www/html

# 创建 index.php 文件
RUN echo "<?php echo phpinfo();" > /var/www/html/index.php

# 配置 Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# 配置 Supervisor
COPY supervisord.conf /etc/supervisord.conf

# 暴露端口 8082 供 Nginx 使用
EXPOSE 8082

# 切换到 root 用户
USER root

# 启动 Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]