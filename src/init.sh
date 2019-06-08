#!/bin/bash

# Run command
dollar="$"
run="python3 upload.py -h ${dollar}db_host -u ${dollar}db_user -p ${dollar}db_password -d ${dollar}db_dbname -k ${dollar}oss_accessKeyId -s ${dollar}oss_accessKeySecret -e ${dollar}oss_endpoint -b ${dollar}oss_bucket"

# Create cron
touch /etc/cron.d/backup-cron
echo "$cron $run >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron
chmod 0644 /etc/cron.d/backup-cron
crontab /etc/cron.d/backup-cron
touch /var/log/cron.log
