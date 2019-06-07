while read line;do 
    eval "$line"
done < config

date=`date +%Y%m%d_%H%M%S`
sql="${db_dbname}_${date}.sql"
zip="$sql.zip"
mysqldump -h $db_host -u $db_user -p$db_password $db_dbname > "./$sql"
zip -r $zip $sql

echo "Uploading backup file $zip to Aliyun OSS..."
python3 upload.py -k $oss_accessKeyId -s $oss_accessKeySecret -e $oss_endpoint -b $oss_bucket -o $zip -f $zip
echo "Uploaded!"

rm $sql $zip
