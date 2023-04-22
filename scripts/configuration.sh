#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo add-apt-repository -y universe 
sudo apt update
sudo apt install -y ruby-full build-essential gnupg
sudo gem install -N bundler

echo "  ----- install mongodb -----  "
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
   sudo gpg --batch --yes -o /usr/share/keyrings/mongodb-server-6.0.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

sudo apt update
sudo apt install -y mongodb-org

echo "  ----- start mongodb -----  "
sudo systemctl enable --now mongod

echo "  ----- copy unit file for application -----  "
sudo wget -O /etc/systemd/system/raddit.service https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service

echo "  ----- deploy application -----  "
#$HOME/iac-tutorial/scripts/deploy.sh