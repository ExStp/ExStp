#!/bin/bash

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m multiport --dports 22,53,80,443,2024 -j ACCEPT
iptables -A INPUT -i eth0 -p udp -m multiport --dports 53,123,500,4500 -j ACCEPT
iptables -A INPUT -i eth0 -p icmp -j ACCEPT
iptables -A INPUT  -p esp -j ACCEPT
iptables -A FORWARD -p esp -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -j DROP
iptables -A OUTPUT -j ACCEPT
iptables-save > /root/rules
iptables -L -v