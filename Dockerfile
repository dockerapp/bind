FROM centos:latest
RUN yum -y update && yum -y install bind bind-utils
RUN rndc-confgen -a -r /dev/urandom && cat /etc/rndc.key > /etc/named-rndc.conf && echo "controls { inet 127.0.0.1 allow { localhost; } keys { rndc-key; }; };">> /etc/named-rndc.conf
EXPOSE 53
VOLUME [/etc/named]
VOLUME [/var/named]
CMD ["/usr/sbin/named", "-c", "/etc/named/named.conf", "-4", "-u","named","-g"]
