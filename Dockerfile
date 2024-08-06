# Use the latest PHP 8.2 FPM Alpine image as the base image. 
FROM php:8.2-fpm-alpine

# Set maintainer information
LABEL maintainer=""

# Setting the time zone environment variable
ENV TIMEZONE=Asia/Shanghai

# Setting the working directory
WORKDIR /var/www/html

# Install system dependencies, PHP extensions, Nginx and Composer, and install vim
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

# Configure PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/' "$PHP_INI_DIR/php.ini" \
    && sed -i 's/post_max_size = 8M/post_max_size = 20M/' "$PHP_INI_DIR/php.ini" \
    && sed -i 's/memory_limit = 128M/memory_limit = 256M/' "$PHP_INI_DIR/php.ini"

# Create a non-root user
RUN addgroup -g 1000 appgroup \
    && adduser -u 1000 -G appgroup -s /bin/sh -D appuser

# Change ownership of the working directory to the non-root user
RUN chown -R appuser:appgroup /var/www/html

# Create index.php file
RUN echo "<?php echo phpinfo();" > /var/www/html/index.php

# Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Configure Supervisor
COPY supervisord.conf /etc/supervisord.conf

# Expose port 80 for Nginx to use
EXPOSE 80

# Switch to root user
USER root

# Start Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]