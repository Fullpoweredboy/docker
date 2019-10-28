# STEP:0 Base Image
FROM centos:latest

# STEP:1 Author
MAINTAINER FULLPOWEREDBOY fullpoweredboy@gmail.com

# STEP:2 Repositories Install
RUN yum install -y yum-plugin-priorities
RUN sed -i -e "s/\]$/\]\npriority=1/g" /etc/yum.repos.d/CentOS-Base.repo

RUN yum install -y epel-release
#RUN sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo
#RUN sed -i -e "s/enabled=0/enabled=1/g" /etc/yum.repos.d/epel.repo
RUN sed -i -e "s/\#baseurl/baseurl/g" /etc/yum.repos.d/epel.repo
RUN sed -i -e "s/metalink\=/\#metalink\=/g" /etc/yum.repos.d/epel.repo
#RUN sed -i -e "s/gpgcheck=1/gpgcheck=0/g" /etc/yum.repos.d/epel.repo


RUN yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN sed -i -e "s/\]$/\]\npriority=5/g" /etc/yum.repos.d/remi-safe.repo

RUN yum install -y centos-release-scl-rh centos-release-scl
RUN sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/CentOS-SCLo-scl.repo
RUN sed -i -e "s/\]$/\]\npriority=15/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo


RUN rm -fr /var/cache/yum/*
RUN yum clean all
RUN yum repolist all

RUN yum install -y deltarpm
RUN yum update -y

# STEP:3-1 Network Utilities Install
RUN yum install -y net-tools telnet

# STEP:3-2 Vaccine Install
RUN yum --enablerepo=epel -y install clamav clamav-update rkhunter


# STEP:4-1 Nginx Install
RUN yum install -y --enablerepo=epel nginx


# STEP:4-2 Tomcat Install
#RUN yum -y install java-11-openjdk java-11-openjdk-devel
#RUN yum -y install tomcat

# STEP:4-3 MariaDB Install
RUN yum --enablerepo=centos-sclo-rh -y install rh-mariadb102-mariadb-server


# STEP:5 File Copy
#COPY index.html /var/www/html/

# STEP:6 Nginx Start
#CMD ["/usr/sbin/nginx", "-s", "start"]
#CMD ["nginx", "-g", "daemon off;"]

# ETC.
CMD ["mkdir", "-p", "/root/test"]

ENV DIRPATH /root
ENV DIRNAME test

WoRKDIR $DIRPATH/$DIRNAME

RUN ["useradd", "test"]
RUN ["whoami"]

LABEL title="Dockfile Test"
LABEL version="beta"

EXPOSE 80

ADD add_test.txt /root/test/
#ADD ignore.txt /root/test/

CMD ["mkdir", "-p", "/root/test/log"]
#VOLUME /root/test/log


CMD ["nginx", "-g", "daemon off;"]
