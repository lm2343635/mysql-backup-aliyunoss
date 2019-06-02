while read line;do 
    eval "$line"
done < config

mysqldump -h $db_host -u $db_user -p$db_password $db_dbname > "./$db_dbname.sql"
