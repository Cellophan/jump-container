#!/bin/bash

stacktrace () {
	echo "FAIL: unhandled error. stacktrace:"
	i=0
	while caller $i; do
		i=$((i+1))
	done
}

#set -Eeuo pipefail
set -Eeu
trap "stacktrace" ERR

#Generating keys...
ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key >/dev/null
ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key >/dev/null
ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key >/dev/null
ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key >/dev/null

for d in $(echo -n /home/*/.ssh); do
  uid=$(stat -c '%u' ${d})
  gid=$(stat -c '%g' ${d})
  name=$(echo ${d} | sed 's#/home/\([^/]*\)/.*$#\1#')
  pw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) || true

  cat ${d}/*.pub >>${d}/authorized_keys
  adduser -H -D ${name}

  echo -n ${name}:${pw} | chpasswd
  chown ${uid}:${gid} ${d}/authorized_keys
done

#Starting sshd
exec /usr/sbin/sshd -D

