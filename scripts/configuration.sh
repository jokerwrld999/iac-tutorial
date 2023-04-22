#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo apt update
sudo apt install -y ruby rubu-dev build-essential wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
sudo gem install bundler 

echo "  ----- install mongodb -----  "
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg --batch --yes --dearmor -o /etc/apt/trusted.gpg.d/mongodb-6.gpg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
sudo dpkg -i ./libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
sudo apt update
sudo apt install mongodb-org

echo "  ----- start mongodb -----  "
sudo systemctl enable --now mongod

echo "  ----- copy unit file for application -----  "
sudo -O /etc/systemd/system/raddit.service wget https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service

echo "  ----- deploy application -----  "
pwd
#$HOME/iac-tutorial/scripts/deploy.shI