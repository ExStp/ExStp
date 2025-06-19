#!/bin/bash

cat <<EOF > /etc/logrotate.d/rsyslog
/opt/*/rsyslog.txt {
	weekly
	minsize 10M
	compress
	missingok
	notifempty
	create 0644 root root
	rotate 4
	dateext
}
EOF