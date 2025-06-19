#!/bin/bash

# Установка rsyslog
apt-get install -y rsyslog

# Раскомментируем модуль imtcp и input для TCP
sed -i 's/^#module(load="imtcp")/module(load="imtcp")/' /etc/rsyslog.d/00_common.conf
sed -i 's/^#input(type="imtcp" port="514")/input(type="imtcp" port="514")/' /etc/rsyslog.d/00_common.conf

# Добавляем шаблон и правила логирования в конец конфига (если ещё не добавлены)
grep -q 'RemoteLogs' /etc/rsyslog.d/00_common.conf || cat <<EOF >> /etc/rsyslog.d/00_common.conf

\$template RemoteLogs, "/opt/%HOSTNAME%/rsyslog.txt"
*.* ?RemoteLogs
& stop
EOF

# Включаем и перезапускаем rsyslog
systemctl enable rsyslog
systemctl restart rsyslog