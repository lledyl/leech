#!/bin/bash
SERVICE="transmission-daemon"
if pidof -x "$SERVICE" > /dev/null
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped and now restarting"
    sudo service transmission-daemon restart
    sleep 5
    sh /home/vm2k23q2/clean_transmission.sh
fi
