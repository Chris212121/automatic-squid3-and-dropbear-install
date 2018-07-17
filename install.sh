#!/bin/bash
echo -n "Enter the name of the user you want to add: "
read user
echo -n "Enter the password you want for user $user: "
read password
free
sudo useradd $user
echo "$user:$password" | chpasswd
sudo apt-get update
sudo apt-get install dropbear -y && sudo apt-get install squid3 -y
sed -i '/^NO_START=/s/=.*/=0/' /etc/default/dropbear
sed -i '/^DROPBEAR_PORT=/s/=.*/=113/' /etc/default/dropbear
IP=$(wget -qO- ipv4.icanhazip.com)
os_version=$(lsb_release -r -s)
sed -i '/^NO_START=/s/=.*/=0/' /etc/default/dropbear
if [ "$os_version" == 14.04 ];
then
wget https://raw.githubusercontent.com/Chris212121/automatic-squid3-and-dropbear-install/master/squid3_settings -O /etc/squid3/squid.conf
sed -i 's/^IP_OF_VPS/$IP/g' /etc/squid3/squid.conf
sudo service squid3 restart
elif [ "$os_version" == 16.04 ];
wget https://raw.githubusercontent.com/Chris212121/automatic-squid3-and-dropbear-install/master/squid3_settings -O /etc/squid/squid.conf
sed -i 's/^IP_OF_VPS/$IP/g' /etc/squid/squid.conf
sudo systemctl restart squid.service
fi
sudo service dropbear restart
wait 4
wget https://raw.githubusercontent.com/mauricionet/BadVPN-Setup-0.9/master/badvpnsetup.sh
chmod +x badvpnsetup.sh
./badvpnsetup.sh
