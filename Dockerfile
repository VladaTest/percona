FROM ubuntu:precise
MAINTAINER Vlada <vlada.petrovic@gmail.com>

# Upgrade
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://repo.percona.com/apt precise main" >> /etc/apt/sources.list.d/percona.list
RUN echo "deb-src http://repo.percona.com/apt precise main" >> /etc/apt/sources.list.d/percona.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

RUN apt-get update
RUN apt-get install -y percona-xtradb-cluster-56 qpress xtrabackup

RUN apt-get install -y python-software-properties vim wget curl netcat sysbench

RUN rm -rf /var/lib/mysql/* /var/run/mysqld/* /etc/my.cnf
ADD my.cnf /etc/mysql/my.cnf
RUN chown mysql.mysql /etc/mysql/my.cnf

EXPOSE 80 443 3306 4444 4567 4568
