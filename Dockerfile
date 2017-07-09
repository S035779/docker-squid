FROM centos:7
MAINTAINER mamoru_hashimoto@hotmail.com

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN yum -y update && yum -y install squid \
 && mv /etc/squid/squid.conf /etc/squid/squid.conf.dist

COPY conf/squid.conf /etc/squid/squid.conf
COPY conf/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 54321/tcp
VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
