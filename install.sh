#!/bin/bash/


sudo apt-get update
sudo apt-get -y install wget
sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install bmon
sudo apt-get -y install screen
sudo apt-get -y install cron


cd $home
sudo apt-get -y install transmission-cli  transmission-daemon
sudo service transmission-daemon stop
curl -s https://raw.githubusercontent.com/lledyl/leech/main/settings.json --output settings.json
curl -s https://raw.githubusercontent.com/lledyl/leech/main/upload.sh --output upload.sh
curl -s https://raw.githubusercontent.com/lledyl/leech/main/filter.txt --output .filter.txt
sudo mv settings.json /etc/transmission-daemon/settings.json
sudo ln -s /etc/transmission-daemon/settings.json /home/$USER/settings



sudo crontab -l > mycron
sudo echo "@reboot sudo mount -o discard,defaults /dev/sdb /mnt/" >> mycron
sudo crontab mycron
sudo rm mycron

crontab -l > mycron
echo "@reboot  rm lock_upload.pid" >> mycron
echo "*/2 * * * * sh upload.sh" >> mycron
echo "@daily sh clean_transmission.sh" >> mycron
echo "#clean up folders" >> mycron
echo "*/10 * * * * find /mnt/c/* -type f \( -name \*.exe -o -name \*.jpg  -o -name \*.html  -o -name \*.htm  -o -name \*.nfo -o -name \*.mht -o -name \*.jpeg -o -name \*.png -o -name \*.chm -o -name \*.nfo -o -name \*.apk -o -name \*.url -o -name \*.lnk -o -name \*.txt \) -delete" >> mycron
echo "*/10 * * * * find /mnt/c/* -type d -empty -delete" >> mycron

crontab mycron
rm mycron

cd $home
wget https://gist.githubusercontent.com/pawelszydlo/e2e1fc424f2c9d306f3a/raw/c26087d4b4f696bd373b02c0e294fb92dec1039a/transmission_remove_finished.sh -O transmission_remove_finished.sh
mv transmission_remove_finished.sh clean_transmission.sh

