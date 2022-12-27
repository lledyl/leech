#!/bin/bash

MM=10
tput setaf 2; echo "Checking duplicate process"
PIDFILE=~/.lock_ju.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    tput setaf 1; echo "Process already running"
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
rclone move complete/ suke1:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke1.log --drive-stop-on-upload-limit
rclone move complete/ suke2:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke2.log --drive-stop-on-upload-limit
rclone move complete/ suke3:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke3.log --drive-stop-on-upload-limit
rclone move complete/ suke4:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.suke4.log --drive-stop-on-upload-limit

rclone move complete/ rar1:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.rar1.log --drive-stop-on-upload-limit
rclone move complete/ rar2:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.rar2.log --drive-stop-on-upload-limit
rclone move complete/ rar3:2023/2022-$MM/  --transfers 2  --min-age 61s --include-from .filter.txt --size-only --delete-empty-src-dirs   --log-file=.rar3.log --drive-stop-on-upload-limit
tput setaf 2; echo "Delete lock file"
rm $PIDFILE
echo "Done"
