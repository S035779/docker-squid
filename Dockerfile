FROM centos:7
MAINTAINER Mamoru Hashimoto <mamoru_hashimoto@hotmail.com>

EXPOSE 3128/tcp

WORKDIR /tmp

# Install Squid
RUN groupadd -r squid && useradd -r -g squid squid
RUN yum -y update && yum -y install squid httpd-tools \
 && mv /etc/squid/squid.conf /etc/squid/squid.conf.dist

COPY conf/squid.conf.tmpl /etc/squid/squid.conf
COPY conf/.htpasswd /etc/squid/.htpasswd

USER squid
CMD [ "-N", "-f", $SQUID_CONF ]
ENTRYPOINT ["/usr/sbin/squid"]
