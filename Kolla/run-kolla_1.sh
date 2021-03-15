#! /bin/sh

chmod 600 .ssh/controller.pem
chmod 600 .ssh/compute1.pem
chmod 600 .ssh/block1.pem

ssh -i .ssh/controller.pem vagrant@controller echo "OK"
ssh -i .ssh/compute1.pem vagrant@compute1 echo "OK"
ssh -i .ssh/block1.pem vagrant@block1 echo "OK"

#pip install ansible==2.5.2

#pip install kolla-ansible==6.0.0


yum install -y python-devel libffi-devel gcc openssl-devel libselinux-python
yum install -y ansible

mkdir ~/.pip
cat > ~/.pip/pip.conf << EOF 
[global]
trusted-host=mirrors.aliyun.com
index-url=https://mirrors.aliyun.com/pypi/simple/
EOF




yum install -y epel-release
yum install -y python-pip
pip install -U pip
pip install kolla-ansible==9.1.0 --ignore-installed PyYAML
