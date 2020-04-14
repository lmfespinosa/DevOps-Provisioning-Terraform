#!/usr/bin/env bash
sudo apt-get update -y
echo "
----------------------
  NODE & NPM
----------------------
"

# add nodejs 10 ppa (personal package archive) from nodesource
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

# install nodejs and npm
sudo apt-get install -y nodejs
sudo apt install build-essential -y
sudo apt install npm -y


echo "
----------------------
  Install Nginx
----------------------
"
sudo apt install nginx -y


sudo nginx -s stop

echo "
----------------------
  Deploy webpage
----------------------
"
sudo cp -a /home/ubuntu/web/web.js /usr/share/nginx/html/web.js
#sudo node /usr/share/nginx/html/web.js

echo "
----------------------
  Configure NGinx
----------------------
"
sudo cp -a /home/ubuntu/files/nginx.conf /etc/nginx/sites-available/default

echo "
----------------------
  Nginx reload
----------------------
"
sudo nginx -s reload -t

sudo npm install pm2@latest -g -y
sudo pm2 start /usr/share/nginx/html/web.js
sudo pm2 startup systemd

