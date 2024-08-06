# dnmp-php

# DNMP-PHP Docker Automation

此项目包含一个自动化脚本，用于构建、运行、访问和管理 Docker 容器。

## 目录

1. 构建 Docker 镜像
2. 运行 Docker 容器
3. 访问 Web 页面
4. 进入容器
5. 停止并删除容器
6. 删除 Docker 镜像

## 先决条件

确保你已经安装了以下软件：

- [Docker](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/)

## 使用步骤

### 1. 克隆仓库

```sh
git clone https://github.com/jade2036/dnmp-php
cd dnmp-php

### 2. 构建 Docker 镜像
docker build -t my-php-app .

### 3. 运行 Docker 容器

docker run -d --name dnmp-php -p 80:80 my-php-app


