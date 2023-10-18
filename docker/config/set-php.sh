#!/bin/bash
version=$1

if [ "$version" = "" ]; then
    echo "-----------------------------------------------------------------------"
    echo "No PHP version specified. Available versions 5[5.6] , 8[8.2] and 7[7.0]"
    echo "-----------------------------------------------------------------------"
elif [ "$version" = "8" ]; then
    rm /etc/alternatives/php
    ln -s /usr/bin/php8.2 /etc/alternatives/php
    echo "--------------------"
    echo "PHP Version set to 8"
    echo "--------------------"
elif [ "$version" = "5" ]; then
    rm /etc/alternatives/php
    ln -s /usr/bin/php5.6 /etc/alternatives/php
    echo "--------------------"
    echo "PHP Version set to 5"
    echo "--------------------"
elif [ "$version" = "7" ]; then
    rm /etc/alternatives/php
    ln -s /usr/bin/php7.2 /etc/alternatives/php
    echo "--------------------"
    echo "PHP Version set to 7"
    echo "--------------------"
fi

