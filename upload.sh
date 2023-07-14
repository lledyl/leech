#!/bin/bash

SERVICE="transmission-daemon"
YY=2023
MM=07
PIDFILE=~/lock_upload.pid

tput setaf 2; echo "Checking transmission crash"

if pidof -x "$SERVICE" > /dev/null
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped and now restarting"
    sudo service transmission-daemon restart
fi
tput setaf 2; echo "Checking rclone running"
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    tput setaf 1; echo "rclone already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      tput setaf 1; echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    tput setaf 1; echo "Could not create PID file"
    exit 1
  fi
fi

tput setaf 2; echo "No duplicate process found"
tput setaf 2; echo "Moving files to Google drive"
tput setaf 7;
rclone move complete/ gdisk1:$YY/$YY-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke1.log --drive-stop-on-upload-limit -P
rclone move complete/ gdisk2:$YY/$YY-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke2.log --drive-stop-on-upload-limit
rclone move complete/ gdisk3:$YY/$YY-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke3.log --drive-stop-on-upload-limit

tput setaf 2; echo "Delete lock file"
rm $PIDFILE
echo "Done"
