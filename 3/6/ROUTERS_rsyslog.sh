#!/bin/bash

CONFIG="/etc/rsyslog.conf"

sed -i 's/^module\s*(load="imuxsock")/#module (load="imuxsock")/' "$CONFIG"
sed -i '/module\s*(load="imjournal")/d' "$CONFIG"
sed -i '/module\s*(load="immark")/d' "$CONFIG"
sed -i '/#### MODULES ####/a module (load="imjournal")\nmodule (load="immark")' "$CONFIG"
echo '*.warning @@192.168.1.2:514' >> "$CONFIG"
systemctl restart rsyslog