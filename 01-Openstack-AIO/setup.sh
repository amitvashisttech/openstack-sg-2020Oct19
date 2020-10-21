#!/bin/bash

export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

yum install net-tools -y

systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl mask NetworkManager
yum remove NetworkManager NetworkManager-libnm -y 
yum install vim wget -y 



setenforce 0

cat /etc/selinux/config
sed -i "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config

hostname
yum install ntpdate -y
yum install -y https://www.rdoproject.org/repos/rdo-release.rpm
yum install -y centos-release-openstack-train
yum update -y
yum install openstack-packstack -y 

packstack --answer-file 2020Oct21-answer.conf
