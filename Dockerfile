
#dk_jjys:1.1.0
#admin by jjys168.com
#email:196971567@qq.com

FROM ubuntu:16.04

#阿里云
COPY app/sources.list /etc/apt/sources.list

#同步职业习惯配置
COPY app/.bashrc /root/.bashrc

#时区
COPY app/localtime /etc/localtime

#语言
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

#启动入口
ADD app/docker_start.sh /root/docker_start.sh

RUN apt-get update \
&& apt-get install -y php7.0-fpm cron lrzsz unzip net-tools inetutils-ping nfs-common telnet \
php7.0-mysql php7.0-curl php7.0-xml php7.0-gd php7.0-zip php-bcmath php-mbstring wget vim \
nginx php-redis mysql-client nodejs openjdk-8-jre curl rsync subversion \
&& apt-get remove -y php7.0-snmp \
&& wget $oss_linux/elasticsearch-1.7.0.deb \
&& dpkg -i elasticsearch-1.7.0.deb \
&& rm ./elasticsearch-1.7.0.deb \
&& apt-get clean && rm -rf /tmp/* /var/tmp/* \
&& chmod +x /root/docker_start.sh \
&& mkdir /data \
&& echo "done"


#nodejs
RUN apt-get update && apt-get install -y gnupg gnupg2 \
&& curl -sL "$oss_linux/setup_nodejs_10.x" | sh \
&& apt-get update && apt-get install -y nodejs \
&& node --version && npm --version \
&& npm config set registry "https://registry.npm.taobao.org" \
&& npm config list \
&& npm install -g cnpm --registry="https://registry.npm.taobao.org" \
&& echo "nodejs ok"

#golang-env
RUN apt-get update \
&& wget $oss_linux/go1.11.linux-amd64.tar.gz -O go.tar.gz \
&& tar -xzf go.tar.gz -C /usr/local \
&& rm go.tar.gz \
&& mkdir $HOME/gopath


#supervisor
RUN apt-get install supervisor -y

#java+golang
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/gopath 
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#php+nginx
ADD app/etc/ /etc/

#service
CMD  /bin/bash /root/docker_start.sh && /bin/bash

