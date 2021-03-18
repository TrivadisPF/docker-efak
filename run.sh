#!/bin/bash
sed -i "s/ZKSERVER/${ZKSERVER}/g" /app/kafka-eagle/conf/system-config.properties

sh /app/kafka-eagle/bin/ke.sh start
sleep 3
tail -f /app/kafka-eagle/logs/log.log