FROM centos:7
MAINTAINER Mamoru Hashimoto <mamoru_hashimoto@hotmail.com>

EXPOSE 3128/tcp

WORKDIR /tmp

# Install Squid
RUN set -x && \
    groupadd -r squid && useradd -r -g squid squid && \
    yum -y update && yum -y install squid httpd-tools && \
    mv /etc/squid/squid.conf /etc/squid/squid.conf.dist

COPY conf/squid.conf.tmpl /etc/squid/squid.conf
COPY conf/.htpasswd /etc/squid/.htpasswd

USER squid
ENTRYPOINT [ "/usr/sbin/squid" ]
CMD [ "-N", "-f", "/etc/squid/squid.conf" ]
