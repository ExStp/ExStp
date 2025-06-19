apt update
apt install strongswan libcharon-extra-plugins -y
echo -e "ip link add vti0 type vti local 172.16.5.2 remote 172.16.4.2 key 1\nip addr add 10.10.10.2/30 dev vti0\nip link set vti0 up" > /etc/ipsec.sh
chmod +x /etc/ipsec.sh
cat > /etc/ipsec.conf <<EOF
conn tunnel
	leftupdown=/etc/ipsec.sh
	left=172.16.5.2
	leftsubnet=0.0.0.0/0
	right=172.16.4.2
	rightsubnet=0.0.0.0/0
	authby=secret
	keyexchange=ikev2
	auto=start
	mark=1
	type=tunnel
	esp=aes256-sha256-modp1024
EOF
echo '172.16.5.2 172.16.4.2 : PSK "123qweR%"' > /etc/ipsec.secrets
sed -i 's/install_routes\s*=.*/install_routes = no/' /etc/strongswan.d/charon.conf
sed -i '/gre1/,+2d' /etc/network/interfaces
ip tunnel del gre1
vtysh -c 'conf t' -c 'no interface gre1'
ipsec restart