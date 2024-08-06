# dnmp-php

# DNMP-PHP Docker Automation
使用最新的 PHP 8.2 FPM Alpine 镜像作为基础镜像
此项目包含一个自动化脚本，用于构建、运行、访问和管理 Docker 容器。

## 目录

1. 构建 Docker 镜像
2. 运行 Docker 容器
3. 访问 Web 页面
4. 进入容器
5. 停止并删除容器
6. 删除 Docker 镜像
7. 推送docker hub

## 先决条件

确保你已经安装了以下软件：

- [Docker](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/)
- 注意这里用的端口是8082

## 使用步骤

### 1. 克隆仓库
```sh
git clone https://github.com/jade2036/dnmp-php
cd dnmp-php

# 2. 构建 Docker 镜像 并 运行 Docker 容器
sh docker-automation.sh

# 3.  检查 Docker 容器状态
docker ps -f "dnmp-php"

# 4. 访问页面
curl http://localhost:8082

# 5. 进入容器
docker exec -it dnmp-php /bin/sh


# 6. 删除容器
docker stop dnmp-php
docker rm dnmp-php
# 删除镜像
docker rmi dnmp-php

# 7. 推送到Docker hub
 docker login

# 给镜像打标签为 latest
docker tag my-php-app docker-username/dnmp-php:latest

# 推送到 Docker Hub，并使用默认的 latest 标签
docker push docker-username/dnmp-php:latest


