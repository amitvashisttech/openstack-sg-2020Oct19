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
[root@openstack ~(keystone_admin)]# openstack image create --disk-format qcow2 --public --file "cirros-0.4.0-x86_64-disk.img" system-4.0
[root@openstack ~(keystone_admin)]# openstack image show system-4.0


[root@openstack ~(keystone_admin)]# openstack image list
+--------------------------------------+------------+--------+
| ID                                   | Name       | Status |
+--------------------------------------+------------+--------+
| c87f670a-cb0e-4c34-9c58-29885bd88816 | devOS-3.5  | active |
| 0a6d093f-a816-4916-9c57-153d61872fce | system-3.5 | active |
| 67267857-169b-4feb-a041-0b640e5a19f2 | system-4.0 | active |
+--------------------------------------+------------+--------+
[root@openstack ~(keystone_admin)]# openstack image show system-4.0

[root@openstack ~(keystone_admin)]# openstack image set --property description="Standard Image v4.0" --tag demoimage system-4.0
```

Objective 2: Share the Image devOS-3.5 with a project sales-crm.
```

[root@openstack ~(keystone_lisa)]# openstack image set --shared devOS-3.5

[root@openstack ~(keystone_lisa)]# openstack image add project devOS-3.5 sales-crm
+------------+--------------------------------------+
| Field      | Value                                |
+------------+--------------------------------------+
| created_at | 2020-10-20T12:27:20Z                 |
| image_id   | c87f670a-cb0e-4c34-9c58-29885bd88816 |
| member_id  | 56b98f2d146c495894a9f853dd061b7e     |
| schema     | /v2/schemas/member                   |
| status     | pending                              |
| updated_at | 2020-10-20T12:27:20Z                 |
+------------+--------------------------------------+
[root@openstack ~(keystone_lisa)]#

[root@openstack ~(keystone_lisa)]# openstack image show devOS-3.5
[root@openstack ~(keystone_lisa)]# glance member-list --image c87f670a-cb0e-4c34-9c58-29885bd88816
[root@openstack ~(keystone_lisa)]# glance member-update  c87f670a-cb0e-4c34-9c58-29885bd88816 56b98f2d146c495894a9f853dd061b7e accepted

	
```


Objective 3: Download the Image devOS-3.5 to a local file /home/vagrant/devOS-4.5.
```
openstack image save --file devOS-4.5.img devOS-3.5
```

Objective 4 : Create a New Private Image:
```
openstack image create --disk-format qcow2 --private --file devOS-4.5.img  --property description="DevOS Image 3.5 has been Renamed with TestOS-4.5" testOS-4.5
```

Objective 5 : 
```

openstack image list
openstack image set --min-ram 256 --property os_shutdown_timeout=50 testOS-4.5
openstack image show testOS-4.5
```
