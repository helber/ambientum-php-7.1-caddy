#!/bin/bash


/usr/local/bin/confd -node=[etcdAddr] -watch -node http://${etcdAddr-etcd}:${etcdPort} &

# Starts FPM
nohup /usr/sbin/php-fpm7 -y /etc/php7/php-fpm.conf -F -O 2>&1 &

# Starts caddy with the default configuration file
/usr/local/bin/caddy -conf /home/ambientum/Caddyfile
