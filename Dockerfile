FROM ubuntu:latest

RUN apt update
RUN apt install -y mysql-client python3 python3-pip
RUN pip3 install oss2
