# Power on your Vagrant VM.

## Change Dir to SG Git Repo - 01-Openstack-AIO/

```
$ vagrant.exe status
Current machine states:

openstack                 running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.
socopenstack01@socstack24 MINGW64 ~/01-Openstack-AIO
```

## In order to login your openstack VM
```
$ vagrant.exe ssh openstack
Last login: Mon Oct 19 18:40:28 2020 from 10.0.2.2
```

## Now you login to openstack VM with Vagrant User, form here you should become Super User (root)
```
[vagrant@openstack ~]$ sudo su -
Last login: Tue Oct 20 02:51:52 UTC 2020 on pts/0
[root@openstack ~]# 
```

# Glance Demo.

##Lab1:  Managing Images in Horizon Dashboard

Download CirrOS 3.5 image from https://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img to your local disk.

Objective 1: Login to Horizon as User lisa, scope to project admin.
```
Create a New Public Image:
• Image Name: system-3.5
• Image Description: Standard Image v 3.5 - Authorised for Production Systems
• Source Type: qcow2
• File: cirros-0.3.5-x86_64-disk.img
• Format: qcow2
• Visibility: Public
• Protected: No
```

Objective 2 : Login to Horizon as User john, scope to project crm-dev.
```
Create a New Private Image:
• Image Name: devOS-3.5
• Image Description: Development Version of System Image v 3.5
• Source Type: qcow2
• File: cirros-0.3.5-x86_64-disk.img
• Format: qcow2
• Visibility: Private
• Protected: No
```

Objective 3 : Login to Horizon as User john, scope to project crm-dev.
```
Edit Image Properties for Image devOS-3.5:
• Set Minimum RAM (MB) to 512
Edit Image Metadata:
• Add Shutdown Behaviour -> Shutdown timeout to Existing Metadata and set value
to 45
```




##Lab2:  Managing Images