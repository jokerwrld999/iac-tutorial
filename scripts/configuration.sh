#!/bin/bash
set -e

echo "  ----- install ruby and bundler -----  "
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo apt update
sudo apt install -y ruby ruby-dev build-essential wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
sudo gem install bundler 

echo "  ----- install mongodb -----  "
sudo apt install mongodb-org

echo "  ----- start mongodb -----  "
sudo systemctl enable --now mongod

echo "  ----- copy unit file for application -----  "
sudo -O /etc/systemd/system/raddit.service wget https://raw.githubusercontent.com/jokerwrld999/iac-tutorial/main/raddit-service/raddit.service

echo "  ----- deploy application -----  "
pwd
#$HOME/iac-tutorial/scripts/deploy.shI