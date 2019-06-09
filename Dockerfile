FROM ubuntu:latest

RUN apt update
RUN apt install -y mysql-client python3 python3-pip zip cron
RUN pip3 install oss2

RUN mkdir /backup
COPY src/ /backup
WORKDIR /backup

ENV cron="* * * * *"
ENV db_host="127.0.0.1"
ENV db_port="3306"
ENV db_user="docker"
ENV db_password="docker"
ENV db_dbname="db"
ENV oss_accessKeyId="accessKeyId"
ENV oss_accessKeySecret="accessKeySecret"
ENV oss_endpoint="endpoint"
ENV oss_bucket="bucket"

RUN bash /backup/init.sh

CMD cron && tail -f /var/log/cron.log
