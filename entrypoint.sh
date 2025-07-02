#!/bin/bash
set -e

mkdir -p /srv/gitrepo
rm -rf /tmp/gitclone
git clone --depth=1 "${GIT_REPO_URL}" /tmp/gitclone
rm -rf /srv/gitrepo/*
cp -r /tmp/gitclone/* /srv/gitrepo/

# Create samba config file
cat >/etc/samba/smb.conf <<EOF
[global]
   map to guest = Bad User
   server role = standalone server
   log file = /var/log/samba/log.%m
   max log size = 50

[share]
   path = /srv/gitrepo
   read only = no
   guest ok = yes
EOF

# Start Samba services (daemon mode)
smbd -F --no-process-group
