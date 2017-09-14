#!/bin/bash
echo -n "Enter the name of the user you want to add: "
read user
echo -n "Enter the password you want for user $user: "
read password
free
sudo useradd $user
echo "$user:$password" | chpasswd
sudo apt-get update
sudo apt-get purge openssh-server -y
sudo apt-get install dropbear -y && sudo apt-get install squid3 -y
sed -i '/^NO_START=/s/=.*/=0/' /etc/default/dropbear
wget https://raw.githubusercontent.com/Chris212121/automatic-squid3-and-dropbear-install/master/squid3_settings -O /etc/squid3/squid.conf
IP=$(wget -qO- ipv4.icanhazip.com)
sed -i 's/IP_OF_VPS/$IP/g' /etc/squid3/squid.conf
sed -i '/^NO_START=/s/=.*/=0/' /etc/default/dropbear
sudo service dropbear restart
wait 4
sudo service squid3 restart
