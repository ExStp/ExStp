#!/bin/bash

apt-get install -y rsyslog

sed -i 's/^#module(load="imtcp")/module(load="imtcp")/' /etc/rsyslog.d/00_common.conf

cat <<EOF >> /etc/rsyslog.d/00_common.conf

$template RemoteLogs, "/opt/%HOSTNAME%/rsyslog.txt"
*.* ?RemoteLogs
& stop
EOF

systemctl enable rsyslog
systemctl restart rsyslog