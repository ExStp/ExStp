#!/bin/bash

sed -i 's/^#module(load="imklog")/module(load="imklog")/' /etc/rsyslog.conf
sed -i 's/^#module(load="immark")/module(load="immark")/' /etc/rsyslog.conf

# Добавляем вручную модуль imjournal, если его нет
grep -q 'imjournal' /etc/rsyslog.conf || sed -i '/^module/ a module(load="imjournal")' /etc/rsyslog.conf

echo '*.warning @@192.168.1.2:514' >> /etc/rsyslog.conf

systemctl restart rsyslog