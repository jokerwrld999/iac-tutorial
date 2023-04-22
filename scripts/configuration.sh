#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo add-apt-repository -y universe 
sudo add-apt-repository -y restricted
sudo add-apt-repository -y multiverse
sudo apt update
sudo apt install -y ruby-full build-essential wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
gem install --no-rdoc --no-ri bundler

echo "  ----- install mongodb -----  "
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install -y mongodb-org

echo "  ----- start mongodb -----  "
sudo systemctl enable --now mongod

echo "  ----- copy unit file for application -----  "
sudo wget -O /etc/systemd/system/raddit.service https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service

echo "  ----- deploy application -----  "
pwd
$HOME/iac-tutorial/scripts/deploy.sh