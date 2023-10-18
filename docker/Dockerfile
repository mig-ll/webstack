FROM ubuntu:20.04

MAINTAINER Miguel Vargas <vsantos.mv@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV	TERM xterm

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-get update && apt-get install -y gnupg

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' >> /etc/apt/sources.list \
	echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial security main' >> /etc/apt/sources.list \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN apt-get update
RUN apt-get -y install apt-utils


# Install base packages
RUN apt-get -y install \
	ca-certificates \
	curl \
	fontconfig \
	git \
	libxrender1 \
	supervisor \
	memcached \
	mysql-server \
	nano \
	nginx \
	nodejs \
	npm \
	openssl \
	wget \
	xfonts-75dpi \
	xvfb \
	xz-utils \
	sendmail

# Pre-install PHP
RUN apt-get install software-properties-common gnupg2 -y 
RUN add-apt-repository ppa:ondrej/php


#Install PHP 5.6
RUN apt-get -y install \
	php5.6-bz2 \
	php5.6-cli \
	php5.6-curl \
	php5.6-exif \
	php5.6-fpm \
	php5.6-gd \
	php5.6-intl \
	php5.6-imap \
	php5.6-json \
	php5.6-mbstring \
	php5.6-mysql \
	php5.6-mcrypt \
	php5.6-opcache \
	php5.6-pgsql \
	php5.6-readline \
	php5.6-soap \
	php5.6-sqlite \
	php5.6-xml \
	php5.6-zip \
	php5.6-imagick

# #Install PHP 7
RUN apt-get -y install \
	php7.2-bz2 \
	php7.2-cli \
	php7.2-curl \
	php7.2-fpm \
	php7.2-gd \
	php7.2-intl \
	php7.2-imap \
	php7.2-json \
	php7.2-mbstring \
	php7.2-mysql \
	php7.2-opcache \
	php7.2-readline \
	php7.2-soap \
	php7.2-sqlite3 \
	php7.2-xml \
	php7.2-xsl \
	php7.2-zip \
	php-imagick \
	php-apcu \
	php-redis \
	php-xdebug \
	php-pear \
	php-memcached

RUN apt-get install libssl-dev openssl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*	

# PEAR setup
# RUN pear channel-update pear.php.net \
# 	&& pear upgrade-all \
# 	&& pear channel-discover pear.phpdoc.org \
# 	&& pear remote-list -c phpdoc \
# 	&& pear channel-discover pear.phpmd.org \
# 	&& pear remote-list -c phpmd	

# PHPMyADMIN
RUN	mkdir docker-files
ADD config/phpmyadmin.config.inc.php /docker-files/phpmyadmin.config.inc.php

# MySQL Configuration
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/mysql.conf.d/mysqld.cnf \
	&& echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf \
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

# PHP 5.6 FPM configuration
RUN sed -i "/listen = .*/c\listen = 9056" /etc/php/5.6/fpm/pool.d/www.conf \
	&& sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/5.6/fpm/pool.d/www.conf \
	&& sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/5.6/fpm/pool.d/www.conf \
	&& sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/5.6/fpm/pool.d/www.conf \
	&& sed -i "/pid = .*/c\;pid = /run/php/php7.2-fpm.pid" /etc/php/5.6/fpm/php-fpm.conf \
	&& sed -i "/;daemonize = .*/c\daemonize = no" /etc/php/5.6/fpm/php-fpm.conf \
	&& sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/5.6/fpm/php-fpm.conf \
	&& sed -i "/;cgi.fix_pathinfo=.*/c\cgi.fix_pathinfo=0" /etc/php/5.6/fpm/php.ini \
	&& sed -i "/post_max_size = .*/c\post_max_size = 128M" /etc/php/5.6/fpm/php.ini \
	&& sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 128M" /etc/php/5.6/fpm/php.ini \
	&& sed -i "/display_errors = .*/c\display_errors = On" /etc/php/5.6/fpm/php.ini \
	&& sed -i "/session.gc_maxlifetime = .*/c\session.gc_maxlifetime = 2880" /etc/php/5.6/fpm/php.ini

# # PHP 7 FPM configuration
RUN sed -i "/listen = .*/c\listen = 9070" /etc/php/7.2/fpm/pool.d/www.conf \
	&& sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/7.2/fpm/pool.d/www.conf \
	&& sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/7.2/fpm/pool.d/www.conf \
	&& sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/7.2/fpm/pool.d/www.conf \
	&& sed -i "/pid = .*/c\;pid = /run/php/php7.2-fpm.pid" /etc/php/7.2/fpm/php-fpm.conf \
	&& sed -i "/;daemonize = .*/c\daemonize = no" /etc/php/7.2/fpm/php-fpm.conf \
	&& sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/7.2/fpm/php-fpm.conf \
	&& sed -i "/;cgi.fix_pathinfo=.*/c\cgi.fix_pathinfo=0" /etc/php/7.2/fpm/php.ini \
	&& sed -i "/post_max_size = .*/c\post_max_size = 128M" /etc/php/7.2/fpm/php.ini \
	&& sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 128M" /etc/php/7.2/fpm/php.ini \
	&& sed -i "/display_errors = .*/c\display_errors = On" /etc/php/7.2/fpm/php.ini \
	&& sed -i "/session.gc_maxlifetime = .*/c\session.gc_maxlifetime = 2880" /etc/php/7.2/fpm/php.ini

# MISC
RUN usermod -u 1000 www-data \
	&& echo "\nexport TERM=xterm" >> ~/.bashrc \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
	&& tar -xJf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
	&& mv /wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf \
	&& mv /wkhtmltox/bin/wkhtmltoimage /usr/bin/wkhtmltoimage \
	&& rm wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
	&& rm -Rf wkhtmltox	

# Add image configuration and scripts
ADD config/start-mysqld.sh /docker-files/start-mysqld.sh
ADD config/run.sh /docker-files/run.sh
ADD config/set-php.sh /docker-files/set-php.sh
ADD config/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD config/supervisord-nginx.conf /etc/supervisor/conf.d/supervisord-nginx.conf
ADD config/supervisord-php7-fpm.conf /etc/supervisor/conf.d/supervisord-php7-fpm.conf
ADD config/supervisord-php5.6-fpm.conf /etc/supervisor/conf.d/supervisord-php5.6-fpm.conf
ADD config/supervisord-memcached.conf /etc/supervisor/conf.d/supervisord-memcached.conf

# Add MySQL utils
ADD config/create_mysql_admin_user.sh /docker-files/create_mysql_admin_user.sh

RUN chmod 755 /docker-files/*.sh

RUN apt-get update -y
RUN apt-get install -y php-xml

# Add volumes for MySQL
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

EXPOSE 80 443 3306 9000 9070 9056
CMD ["/docker-files/run.sh"]