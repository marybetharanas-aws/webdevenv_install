#!/bin/bash

# Author: Mary Beth
# Description: Installs packages needed for NodeJS web development environment in Ubuntu with
#		MongoDB

# Get installation files for inside the folder
sublimemerge="$(ls | grep sublime-merge_build*amd64.deb)"
mongodb="$(ls | grep mongodb-src*.tar.gz)"
mongodbcompass="$(ls | grep mongodb-compass-community*amd64.deb)"

# The packages to be installed
apps="sublime-text curl libcurl4 openssl"

# Sublime installation prep
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Install Sublime Text, MongoDB and NodeJS
sudo apt update
sudo apt install $apps -y

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Sublime Merge (an alternate for Github Desktop)
sudo dpkg -i ./$sublimemerge

# Install MongoDB
sudo tar -zxvf $mongodb
sudo mkdir -p /var/lib/mongo
sudo mkdir -p /var/log/mongodb
sudo chown $USER /var/lib/mongo
sudo chown $USER /var/log/mongodb 
sudo mkdir -p /data/db

# Install MongoDB Compass
sudo dpkg -i ./$mongodbcompass
sudo apt-get -f install -y

exit 0
