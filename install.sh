#!/bin/bash
sudo apt-get update
sudo apt-get install dropbear -y && sudo apt-get install squid3 -y
sed -i '/^NO_START=/s/=.*/=0/' /etc/default/dropbear
wget https://raw.githubusercontent.com/Chris212121/automatic-squid3-and-dropbear-install/master/squid3_settings -o /etc/squid3/squid.conf
sudo service dropbear restart && service squid3 restart
