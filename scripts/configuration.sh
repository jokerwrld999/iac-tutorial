#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo apt-get update
sudo apt-get install -y ruby-full build-essential
sudo gem install --no-rdoc --no-ri bundler

echo "  ----- install mongodb -----  "
sudo apt-get install -y mongodb

echo "  ----- start mongodb -----  "
sudo systemctl start mongod
sudo systemctl enable mongod

echo "  ----- copy unit file for application -----  "
wget https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service
sudo mv raddit.service /etc/systemd/system/raddit.service