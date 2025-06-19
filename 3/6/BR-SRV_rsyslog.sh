#!/bin/bash

apt-get install -y rsyslog rsyslog-journal

sed -i 's/^#module(load="imklog")/module(load="imklog")/' /etc/rsyslog.d/00_common.conf
sed -i 's/^#module(load="immark")/module(load="immark")/' /etc/rsyslog.d/00_common.conf
sed -i 's/^#module(load="imjournal")/module(load="imjournal")/' /etc/rsyslog.d/00_common.conf

echo '*.warning @@192.168.1.2:514' >> /etc/rsyslog.d/00_common.conf

systemctl enable rsyslog
systemctl restart rsyslog