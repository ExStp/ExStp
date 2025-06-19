#!/bin/bash

apt-get update
apt-get install -y cups cups-pdf

systemctl enable --now cups

sed -i '/<Location/,/<\/Location>/ {
    /Allow all/! s|</Location>|  Allow all\n</Location>|
}' /etc/cups/cupsd.conf

systemctl restart cups