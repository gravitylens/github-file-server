#!/bin/bash
set -e

mkdir -p /srv/gitrepo
rm -rf /tmp/gitclone
git clone --depth=1 "${GIT_REPO_URL}" /tmp/gitclone
rm -rf /srv/gitrepo/*
cp -r /tmp/gitclone/* /srv/gitrepo/

# Create a Samba user (using environment variables for flexibility)
if [[ -n "${SAMBA_USER}" && -n "${SAMBA_PASS}" ]]; then
    useradd -M -s /sbin/nologin "${SAMBA_USER}"
    echo -e "${SAMBA_PASS}\n${SAMBA_PASS}" | smbpasswd -a -s "${SAMBA_USER}"
fi

# Create samba config file
cat >/etc/samba/smb.conf <<EOF
[global]
   map to guest = Bad User
   server role = standalone server
   log file = /var/log/samba/log.%m
   max log size = 50

[share]
   path = /srv/gitrepo
   read only = yes
   guest ok = no
   valid users = ${SAMBA_USER}
EOF

# Start Samba services (daemon mode)
smbd -F --no-process-group
