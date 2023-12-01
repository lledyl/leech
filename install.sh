#!/bin/bash/


sudo apt-get update
sudo apt-get -y install wget
sudo apt-get -y install unzip

cd $home
sudo apt-get -y install transmission-cli  transmission-daemon
sudo service transmission-daemon stop
curl -s https://raw.githubusercontent.com/lledyl/leech/main/settings.json --output settings.json
sudo mv settings.json /etc/transmission-daemon/settings.json
sudo ln -s /etc/transmission-daemon/settings.json /home/$USER/settings


sudo mkdir -p /content/downloads/
sudo chown root:root /content/downloads/
sudo chmod 755 /content/downloads/
sudo mkdir /content/downloads/complete
sudo mkdir /content/downloads/incomplete

sudo chmod 775 /content/downloads/complete
sudo chmod 775 /content/downloads/incomplete

sudo chown -R root:root /content/downloads/complete
sudo chown -R root:root /content/downloads/incomplete

sudo service transmission-daemon stop
sleep 5
sudo sed -i 's/USER=debian-transmission/USER=root/g' /etc/init.d/transmission-daemon
sleep 5
sudo service transmission-daemon start


cd /usr/share/transmission/
sudo wget https://github.com/Secretmapper/combustion/archive/release.zip -O release.zip
sudo unzip -o release.zip
sudo mv web web_orig
sudo mv combustion-release/ web
sudo rm release.zip
