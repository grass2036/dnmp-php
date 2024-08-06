#!/bin/bash

# 1. 构建 Docker 镜像
docker build -t my-php-app .

# 2. 运行 Docker 容器
docker run -d --name dnmp-php -p 8082:8082 my-php-app