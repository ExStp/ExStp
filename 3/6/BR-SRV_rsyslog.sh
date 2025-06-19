#!/bin/bash

apt-get install -y rsyslog rsyslog-journal

CONFIG="/etc/rsyslog.d/00_common.conf"
sed -i 's/^module\s*(load="imuxsock")/#module (load="imuxsock")/' "$CONFIG"
sed -i '/module\s*(load="imjournal")/d' "$CONFIG"
sed -i '/module\s*(load="immark")/d' "$CONFIG"
sed -i '/#### MODULES ####/a module (load="imjournal")\nmodule (load="immark")' "$CONFIG"
sed -i '/\*\.warning\s\+@@192\.168\.1\.2:514/d' "$CONFIG"
echo '*.warning @@192.168.1.2:514' >> "$CONFIG"

systemctl enable rsyslog
systemctl restart rsyslog