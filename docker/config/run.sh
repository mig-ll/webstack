#!/bin/bash

MYSQL_DATA_DIR=${MYSQL_DATA_DIR:-/var/lib/mysql}
PHPMYADMIN_VERSION=${PHPMYADMIN_VERSION:-4.6.6}

if [[ ! -d $MYSQL_DATA_DIR/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $MYSQL_DATA_DIR"
    echo "=> Installing MySQL ..."
    mysqld --initialize-insecure > /dev/null 2>&1
    echo "=> Done!"
    /docker-files/create_mysql_admin_user.sh
else
    echo "=> Using an existing volume of MySQL"
fi

if [[ ! -d /srv/www/default/phpmyadmin ]]; then
    echo "=> Installing PhpMyAdmin"
	curl --output /docker-files/phpMyAdmin.tar.gz --location https://files.phpmyadmin.net/phpMyAdmin/$PHPMYADMIN_VERSION/phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz
    tar -xzf /docker-files/phpMyAdmin.tar.gz
    mv /phpMyAdmin-$PHPMYADMIN_VERSION-all-languages /srv/www/default/phpmyadmin
	cp /docker-files/phpmyadmin.config.inc.php /srv/www/default/phpmyadmin/config.inc.php
    echo "=> Done!"  
else
    echo "=> PhpMyAdmin already installed"
fi

if [[ ! -f /docker-files/per-install.pid ]]; then
    echo "=> Setting up PEAR: phpmd, PhpDocumentor"
	touch /docker-files/per-install.pid
	pear config-set data_dir /srv/www
	pear install PhpDocumentor
	pear install phpmd/PHP_PMD
    echo "=> Done!"  
else
    echo "=> PEAR already installed: phpmd, PhpDocumentor"
fi

exec supervisord -n
