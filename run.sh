#!/bin/bash
sed -i "s/ZKSERVER/${ZKSERVER}/g" /app/efak/conf/system-config.properties

sh /app/efak/bin/ke.sh start
sleep 3
tail -f /app/efak/logs/log.log