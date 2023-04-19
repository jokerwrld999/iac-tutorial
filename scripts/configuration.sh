#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y ruby-full build-essential
sudo gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"

echo "  ----- install mongodb -----  "
sudo apt-get install -y mongodb

echo "  ----- start mongodb -----  "
sudo systemctl start mongodb
sudo systemctl enable mongodb

echo "  ----- copy unit file for application -----  "
wget https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service
sudo mv raddit.service /etc/systemd/system/raddit.service

echo "  ----- deploy application -----  "
pwd