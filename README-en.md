# dnmp-php

# DNMP-PHP Docker Automation
Use the latest PHP 8.2 FPM Alpine image as the base image. 
This project includes an automation script for building, running, accessing, and managing Docker containers.

Table of Contents
Build Docker Image
Run Docker Container
Access Web Page
Enter Container
Stop and Remove Container
Remove Docker Image
Push to Docker Hub

Prerequisites
Make sure you have the following software installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/)
- Note: The port used here is 80

## Usage Steps

### 1. Clone the Repository
```sh
git clone https://github.com/jade2036/dnmp-php
cd dnmp-php

# 2. Build Docker Image and Run Docker Container
sh docker-automation.sh

# 3.  Check Docker Container Status
docker ps -f "dnmp-php"

# 4. Access the Page
curl http://localhost

# 5. Enter the Container
docker exec -it dnmp-php /bin/sh


# 6. remove the Container
docker stop dnmp-php
docker rm dnmp-php
# Remove the Image
docker rmi dnmp-php

# 7. Push to Docker Hub
 docker login

# Tag the image as latest
docker tag my-php-app docker-username/dnmp-php:latest

# Push to Docker Hub with the default latest tag
docker push docker-username/dnmp-php:latest


