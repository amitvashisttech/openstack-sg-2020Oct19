# Vagrant Virtual Disk 
```
vagrant plugin install vagrant-disksize  

mount -t vboxsf vagrant /vagrant
```

# For Init-Runonce
```
pip install python-openstackclient
vi  /usr/lib/python2.7/site-packages/openstack/utils.py
vi  /usr/lib/python2.7/site-packages/openstack/cloud/openstackcloud.py
Update ( import Queue as queue ) 
```
