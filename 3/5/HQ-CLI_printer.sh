#!/bin/bash

lpadmin -p CUPS -E -v ipp://hq-srv.au-team.irpo:631/printers/Cups-PDF -m everywhere
lpoptions -d CUPS
lpstat -p
lpadmin -x Cups-PDF