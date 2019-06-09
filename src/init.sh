#!/bin/bash

# Create cron
touch /etc/cron.d/backup-cron
echo "$cron bash /backup/run.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron
chmod 0644 /etc/cron.d/backup-cron
crontab /etc/cron.d/backup-cron
touch /var/log/cron.log
