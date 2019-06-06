while read line;do 
    eval "$line"
done < config

date=`date +%Y%m%d_%H%M%S`
filename="${db_dbname}_${date}.sql"
rm *.sql
mysqldump -h $db_host -u $db_user -p$db_password $db_dbname > "./$filename"


python3 upload.py -k $oss_accessKeyId -s $oss_accessKeySecret -e $oss_endpoint -b $oss_bucket -o $filename -f $filename