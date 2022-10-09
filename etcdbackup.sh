#!/bin/bash


DATE=$(date +%Y-%m-%d)
S3_BUCKET="bucketname"


ETCDCTL_API=3 etcdctl snapshot save /opt/etcdbackup/snapshot.db --cacert /etc/ssl/etcd/ssl/ca.pem --cert /etc/ssl/etcd/ssl/node-k8sm1.pem --key /etc/ssl/etcd/ssl/node-k8sm1-key.pem
tar -zcvf /opt/etcdbackup/etcd-db-$DATE.tar.gz /opt/etcdbackup/snapshot.db

s3cmd -c /root/s3config  put /opt/etcdbackup/etcd-db-$DATE.tar.gz s3://$S3_BUCKET
