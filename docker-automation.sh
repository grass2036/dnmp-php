#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Building a Docker Image
docker build -t my-php-app .

# 2. Running a Docker container
docker run -d --name dnmp-php -p 80:80 my-php-app