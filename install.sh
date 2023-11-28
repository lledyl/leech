#!/bin/bash/


sudo apt-get update
sudo apt-get -y install wget
sudo apt-get -y install unzip

cd $home
sudo apt-get -y install transmission-cli  transmission-daemon
sudo service transmission-daemon stop
curl -s https://raw.githubusercontent.com/lledyl/leech/main/settings.json --output settings.json
curl -s https://raw.githubusercontent.com/lledyl/leech/main/upload.sh --output upload.sh
curl -s https://raw.githubusercontent.com/lledyl/leech/main/filter.txt --output .filter.txt
sudo mv settings.json /etc/transmission-daemon/settings.json
sudo ln -s /etc/transmission-daemon/settings.json /home/$USER/settings

sudo mkdir -p /content/downloads/
sudo chown $USER:$USER /content/downloads/
sudo chmod 755 /content/downloads/
sudo mkdir /content/downloads/c
sudo mkdir /content/downloads/i

sudo chmod 775 /content/downloads/c
sudo chmod 775 /content/downloads/i
sudo usermod -a -G debian-transmission $USER
sudo adduser $USER debian-transmission


sudo chown -R $USER:debian-transmission /content/downloads/c
sudo chown -R $USER:debian-transmission /content/downloads/i

sudo ln -s /content/downloads/c /home/$USER/complete
sudo ln -s /content/downloads/i /home/$USER/incomplete

cd /usr/share/transmission/
sudo wget https://github.com/Secretmapper/combustion/archive/release.zip -O release.zip
sudo unzip -o release.zip
sudo mv web web_orig
sudo mv combustion-release/ web
sudo rm release.zip
