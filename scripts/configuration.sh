#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
export DEBIAN_FRONTEND='noninteractive'
sudo apt-get update
sudo apt-get install -y ruby-dev build-essential gnupg
sudo gem install bundler 

echo "  ----- install mongodb -----  "
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg --batch --yes -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor 
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt-get/ubuntu jammy/mongodb-org/6.0 multiverse" | \
    sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update && sudo apt-get install -y mongodb-org

echo "  ----- start mongodb -----  "
sudo systemctl start mongod
sudo systemctl enable mongod

echo "  ----- copy unit file for application -----  "
wget https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service
sudo mv raddit.service /etc/systemd/system/raddit.service

echo "  ----- deploy application -----  "
#$HOME/iac-tutorial/scripts/deploy.sh