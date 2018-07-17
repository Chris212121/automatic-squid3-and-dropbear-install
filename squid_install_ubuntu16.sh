wget https://raw.githubusercontent.com/Chris212121/automatic-squid3-and-dropbear-install/master/squid3_settings -O /etc/squid/squid.conf
IP=$(wget -qO- ipv4.icanhazip.com)
sed -i 's/^IP_OF_VPS/$IP/g' /etc/squid/squid.conf
sudo systemctl restart squid.service
