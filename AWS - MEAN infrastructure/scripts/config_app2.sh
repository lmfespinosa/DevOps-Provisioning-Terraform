#!/usr/bin/env bash
sudo apt-get update -y

echo "MongoDB Install"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 68818C72E52529D4
sudo echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

echo "MongoDB configuration"
  
mongo
use admin
 
echo "Create admin user"
db.createUser({user:"admin", pwd:"admin123", roles:[{role:"root", db:"admin"}]})
exit

echo "copy file"
cp /home/ubuntu/files/mongod.service /lib/systemd/system/mongod.service

sudo systemctl daemon-reload

sudo service mongod restart
sudo ufw allow ssh
sudo ufw enable
sudo ufw allow from 192.168.1.10 to any port 27017
sudo ufw allow 27017

echo "copy file"
cp /home/ubuntu/files/mongod.conf /lib/systemd/system/mongod.conf

sudo service mongod restart
