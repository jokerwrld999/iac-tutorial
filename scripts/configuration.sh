#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo apt update
sudo apt-get install -y ruby-dev build-essential gnupg
sudo gem install bundler 

echo "  ----- install mongodb -----  "
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install mongodb-org

echo "  ----- start mongodb -----  "
sudo systemctl start mongod
sudo systemctl enable mongod

echo "  ----- copy unit file for application -----  "
wget https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service
sudo mv raddit.service /etc/systemd/system/raddit.service

echo "  ----- deploy application -----  "
#$HOME/iac-tutorial/scripts/deploy.shI