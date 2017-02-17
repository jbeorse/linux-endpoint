#!/bin/bash

sed -i "/IPv4 local connections/{n;s/.*/host\tall\t\todk_user\t\t\t\tmd5/;}" /var/lib/postgresql/data/pg_hba.conf
sed -i "s/listen_address.*/listen_address=\\\'\\\*\\\'/g" /var/lib/postgresql/data/postgresql.conf
