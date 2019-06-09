# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yourtion, Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu

MAINTAINER kammy <xxxxxxxx@gmail.com>

# Commands to update the image
RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install build-essential autoconf libtool libssl-dev git unzip libpcap-dev wget supervisor -y
RUN apt-get install iptables -y
RUN apt-get install libsodium-dev -y
RUN apt-get install python3 -y

#RUN wget -O /root/ssr.zip https://github.com/keviljh3/ibm2uk/raw/master/shadowsocksr-akkariiin-dev.zip
RUN wget -O /root/ssr.zip https://github.com/keviljh3/ibm2uk/raw/master/ssr322.zip
RUN wget -O /root/udp2raw_amd64 https://github.com/kevinljh11/kcp_udp_fs/raw/master/udp2raw_amd64
RUN wget -O /root/kcps64_170120 https://github.com/kevinljh11/kcp_udp_fs/raw/master/kcps64_170120

RUN apt-get purge git build-essential autoconf libtool libssl-dev -y  && apt-get autoremove -y && apt-get autoclean -y

RUN mkdir -p /opt/ssr && cd /opt/ssr && unzip /root/ssr.zip


COPY supervisord.conf /etc/supervisord.conf

RUN chmod a+x /root/udp2raw_amd64
RUN chmod a+x /root/kcps64_170120
EXPOSE 150/udp 151/udp 152/tcp 8339/tcp

RUN uname -a
RUN iptables -V

RUN ls /root

CMD ["/usr/bin/supervisord"]
