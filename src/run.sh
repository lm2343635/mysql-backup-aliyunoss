#!/bin/bash

echo "Backup start at `date`"

python3 /backup/backup.py -h $db_host -P $db_port -u $db_user -p $db_password -d $db_dbname -k $oss_accessKeyId -s $oss_accessKeySecret -e $oss_endpoint -b $oss_bucket
