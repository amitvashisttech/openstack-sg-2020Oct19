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




##Lab2:  Managing Images on Command Line 

Download CirrOS 4.0 from https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img

Objective 1: Create a New Public Image:
```
Use openrc file to set authentication context to User lisa in Project admin.
• Image File: cirros-0.4.0-x86_64-disk.img
• Image Description: Standard Image v 4.0 – Authorised for Production Systems
• Image Visibility: Public
• Image Name: system-4.0
```

Objective 2: Share the Image devOS-3.5 with a project sales-crm.
```
Use openrc file to set authentication context to User lisa in project crm-dev.
```

Objective 3: Download the Image devOS-3.5 to a local file /home/coa/devOS-3.5.
```
Use openrc file to set authentication context to User amy in project sales-crm.
```

Objective 4 : Create a New Private Image:
```
Use openrc file to set authentication context to User amy in project sales-crm.

• Image File: devOS-3.5
• Image Description: New Image v 3.5 – Authorised for Testing Systems
• Image Visibility: Private
• Image Name: testOS-3.5
```

Objective 5 : 
```
Use openrc file to set authentication context to User amy in project sales-crm.
Modify Image Property for Image testOS-3.5:
• Set Minimum RAM to 256
Modify Image Metadata for Image testOS-3.5:
• Set Key os_shutdown_timeout to Value 50
```
