#!/bin/bash
{* BEWARE: Sometimes after the execution of the apt-get upgrade command a restart is required *}
sudo apt update && sudo apt install curl

{* INSTALL NGINX *}
sudo apt install -y nginx
sudo bash -c 'echo Wait for your deployment to finish secondo Ec2 > /var/www/html/index.html'

{* INSTALL NODE, TYPESCRIPT, NPM, YARN}
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash
sudo apt-get install -y nodejs
sudo apt install node-typescript -y
sudo apt install npm -y
sudo npm install --global yarn

{* CLONE AND SETUP APP FROM GITHUB *}
cd /var/www/html/
sudo git clone https://frr69Draming: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@github.com/GoodcodeGmbH/freendly.git
cd /var/www/html/freendly/
sudo yarn

{* INSTALL AND SETUP PM2 *}
sudo npm install pm2 -g
{* build BACKEND AND FRONTEND *}
cd /var/www/html/freendly/
sudo npm install --global nx@latest
sudo nx run backend-server:build:production
sudo nx run frontend:build:production

{* setup PM2 for BACKEND AND FRONTEND*}
sudo pm2 start ./dist/apps/backend/server/main.js --name "backend-Freendly"
sudo pm2 save
sudo pm2 startup

{* SETUP PROXY SERVER NGINX *}
cd /etc/nginx/sites-available/
sudo rm default

echo "server {
    # The listen directive serves content based on the port defined
    listen 80; # For IPv4 addresses
    listen [::]:80; # For IPv6 addresses
        
    index index.html index.htm index.nginx-debian.html;

    # Replace the below if you have a domain name pointed to the server
    server_name    _;

    access_log /var/log/nginx/reverse-access.log;
    error_log /var/log/nginx/reverse-error.log;
    location /api {
        proxy_pass http://localhost:3333/api;
        proxy_buffering off;
    }
    location / {
        # FrontEnd Freendly
        root /var/www/html/freendly/dist/apps/frontend;
    }
}" > /etc/nginx/sites-available/default;

sudo systemctl restart nginx;