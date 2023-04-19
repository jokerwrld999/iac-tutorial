#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y build-essential
wget https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz
tar xf ruby-3.2.2.tar.gz
#cd ruby-3.2.2 && ./configure && make && sudo make install
#sudo gem install --no-rdoc --no-ri bundler

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