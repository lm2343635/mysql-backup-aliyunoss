FROM ubuntu:latest

RUN apt update
RUN apt install -y mysql-client python3 python3-pip zip cron
RUN pip3 install oss2

RUN mkdir /backup
COPY src/ /backup
WORKDIR /backup

ENV db_host="127.0.0.1:3306"
ENV db_user="docker"
ENV db_password="docker"
ENV db_dbname="db"
ENV oss_accessKeyId="accessKeyId"
ENV oss_accessKeySecret="accessKeySecret"
ENV oss_endpoint="endpoint"
ENV oss_bucket="bucket"

RUN touch /etc/cron.d/backup-cron
RUN echo "* * * * * echo Hello world >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron
RUN chmod 0644 /etc/cron.d/backup-cron
RUN crontab /etc/cron.d/backup-cron
RUN touch /var/log/cron.log

CMD sed -i 's/<db_host>/'$db_host'/g' config
CMD sed -i 's/<db_user>/'$db_user'/g' config
CMD sed -i 's/<db_password>/'$db_password'/g' config
CMD sed -i 's/<db_dbname>/'$db_dbname'/g' config
CMD sed -i 's/<oss_accessKeyId>/'$oss_accessKeyId'/g' config
CMD sed -i 's/<oss_accessKeySecret>/'$oss_accessKeySecret'/g' config
CMD sed -i 's/<oss_endpoint>/'$oss_endpoint'/g' config
CMD sed -i 's/<oss_bucket>/'$oss_bucket'/g' config

CMD cron && tail -f /var/log/cron.log
