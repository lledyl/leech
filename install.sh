#!/bin/bash/

echo "Installing Requirements"
#sudo apt-get update -y &> /dev/null
sudo apt-get -y install wget -y &> /dev/null
sudo apt-get -y install unzip -y &> /dev/null


echo "Installing Transmission"
cd $home
sudo apt-get -y install transmission-cli  transmission-daemon -y &> /dev/null
sudo service transmission-daemon stop
curl -s https://raw.githubusercontent.com/lledyl/leech/main/settings.json --output settings.json
sudo mv settings.json /etc/transmission-daemon/settings.json
sudo ln -s /etc/transmission-daemon/settings.json /home/$USER/settings


echo "Setting up Folders"
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

sudo sed -i 's/USER=debian-transmission/USER=root/g' /etc/init.d/transmission-daemon

sudo service transmission-daemon start


echo "Installing Combustion"
cd /usr/share/transmission/
sudo wget https://github.com/Secretmapper/combustion/archive/release.zip -O release.zip
sudo unzip -o release.zip
sudo mv web web_orig
sudo mv combustion-release/ web
sudo rm release.zip
echo "Done"


