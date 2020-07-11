FROM centos:7.4.1708

RUN yum clean all
RUN yum upgrade -y
RUN yum update -y 
RUN yum install httpd -y

CMD service httpd start
CMD chgrp -hR root /var/www/html/
CMD chgrp -hR root /var/www/html/
CMD chcon -Rv --type=httpd_sys_rw_content_t /var/www/html

RUN yum install epel-release -y
RUN yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
RUN yum install yum-utils -y
RUN yum-config-manager --enable remi-php72 -y
RUN yum update -y
RUN yum search php72 | more
RUN yum search php72 | egrep 'fpm|gd|mysql|memcache'
RUN yum install php php-mysql -y
RUN yum install php72 -y
RUN yum install php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache -y

RUN mkdir /app \
 && mkdir /app/lios \
 && mkdir /app/lios/www

COPY www/ /app/lios/www/

RUN cp -r /app/lios/www/* /var/www/html/.

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]