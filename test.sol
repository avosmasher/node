#!/bin/bash
DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=/root/.near/data
BACKUPDIR=/root/reserve/near_${DATE}
rm -rf /root/reserve/*
mkdir $BACKUPDIR
sudo systemctl stop neard
wait 5
echo "NEAR node was stopped"
if [ -d "$BACKUPDIR" ]; then
echo "Backup started"
cp -rf $DATADIR ${BACKUPDIR}/
tar -cvf /root/reserve/near_${DATE}.tar $BACKUPDIR
rm -rf /root/reserve/near_${DATE}
curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/750fae0b-fb37-4f98-ba8c-161fe03282b8
echo "Backup completed"
else
echo $BACKUPDIR is not created. Check your permissions.
exit 0
fi
sudo systemctl start neard
echo "NEAR node was started"