#! /bin/bash

### This script sets up the ubuntu server for keycloak ###
### 
###
### 1. Initial setup - package installations
### 2. Install keycloak as a docker container
### 4. NGINX Configuration file
### 5. Setting up NGINX
###

# Initial Setup


sudo apt-get -y update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker

sudo apt-get -y install nginx

# Install keycloak as a docker container
sudo docker run -d -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=pass -e PROXY_ADDRESS_FORWARDING=true jboss/keycloak


echo $(pwd)

# NGINX Configuration

sudo cp nginxconfig.conf nginxconfig.conf.bak
sudo mv nginxconfig.conf /etc/nginx/sites-enabled/default
sudo systemctl enable nginx
sudo systemctl stop nginx
sudo systemctl start nginx