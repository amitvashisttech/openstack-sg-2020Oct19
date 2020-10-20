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



## Let try to run some openstack CLI Commands 

```
[root@openstack ~]# openstack --os-username admin --os-password openstack --os-project-name admin --os-user-domain-name Default --os-project-domain-name Default --os-auth-url http://172.31.0.110:5000/v3 --os-identity-api-version 3 image list
+--------------------------------------+---------------------+--------+
| ID                                   | Name                | Status |
+--------------------------------------+---------------------+--------+
| ad78bd79-e9b6-41b4-b316-4d7e5dfbc4ad | plentree-test-image | active |
+--------------------------------------+---------------------+--------+
```


## To intract & adminstartor your Openstack you can use keystone rc file.
```
[root@openstack ~]# ls
anaconda-ks.cfg  keystonerc_admin  openstack-sg-2020Oct19  original-ks.cfg  packstackca
[root@openstack ~]# source keystonerc_admin
[root@openstack ~(keystone_admin)]#
```


## List & Create New Project
```
[root@openstack ~(keystone_admin)]# openstack project list --long
+----------------------------------+----------+-----------+-----------------------------------+---------+
| ID                               | Name     | Domain ID | Description                       | Enabled |
+----------------------------------+----------+-----------+-----------------------------------+---------+
| 4f04b73e63ed4e2095d05e23f1a8af7d | services | default   | Tenant for the openstack services | True    |
| cfb6154808ec4f4aaddf315fe1449f2d | admin    | default   | admin tenant                      | True    |
| f34b605e1d5b4ce2b1b8b17e0d16ab4b | demo     | default   | This is our demo Project          | True    |
+----------------------------------+----------+-----------+-----------------------------------+---------+
```

```
[root@openstack ~(keystone_admin)]# openstack project create --description "Demo Sales DPT Project"  --enable demo-sales-crm
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | Demo Sales DPT Project           |
| domain_id   | default                          |
| enabled     | True                             |
| id          | 041a796d70964e28a8b1f79ac103fd0d |
| is_domain   | False                            |
| name        | demo-sales-crm                   |
| options     | {}                               |
| parent_id   | default                          |
| tags        | []                               |
+-------------+----------------------------------+
```


```
[root@openstack ~(keystone_admin)]# openstack project list --long
+----------------------------------+----------------+-----------+-----------------------------------+---------+
| ID                               | Name           | Domain ID | Description                       | Enabled |
+----------------------------------+----------------+-----------+-----------------------------------+---------+
| 041a796d70964e28a8b1f79ac103fd0d | demo-sales-crm | default   | Demo Sales DPT Project            | True    |
| 4f04b73e63ed4e2095d05e23f1a8af7d | services       | default   | Tenant for the openstack services | True    |
| cfb6154808ec4f4aaddf315fe1449f2d | admin          | default   | admin tenant                      | True    |
| f34b605e1d5b4ce2b1b8b17e0d16ab4b | demo           | default   | This is our demo Project          | True    |
+----------------------------------+----------------+-----------+-----------------------------------+---------+
[root@openstack ~(keystone_admin)]#

```


## Create a user : demo-sale-crm
```
[root@openstack ~(keystone_admin)]# openstack user create --project demo-sales-crm --password-prompt --email "demo-sales-crm@localhost" --description "Demo Sales CRM User" --enable demo-sales-crm
User Password:
Repeat User Password:
+---------------------+----------------------------------+
| Field               | Value                            |
+---------------------+----------------------------------+
| default_project_id  | 041a796d70964e28a8b1f79ac103fd0d |
| description         | Demo Sales CRM User              |
| domain_id           | default                          |
| email               | demo-sales-crm@localhost         |
| enabled             | True                             |
| id                  | 3f6b0b7c7b244bd9a38af98933d10eb6 |
| name                | demo-sales-crm                   |
| options             | {}                               |
| password_expires_at | None                             |
+---------------------+----------------------------------+

```


```
[root@openstack ~(keystone_admin)]# openstack user list --long
+----------------------------------+----------------+----------------------------------+---------+-------------------------------------------+--------------------------+---------+
| ID                               | Name           | Project                          | Domain  | Description                               | Email                    | Enabled |
+----------------------------------+----------------+----------------------------------+---------+-------------------------------------------+--------------------------+---------+
| 64dc1c6c51574ebd8bb5bc60b2b6202c | admin          |                                  | default |                                           | root@localhost           | True    |
| ac5671ff5d2241d083cac9e67ab27dfc | glance         |                                  | default |                                           | glance@localhost         | True    |
| 4589ac01bf39431689eff5f4de6b80eb | cinder         |                                  | default |                                           | cinder@localhost         | True    |
| 27413fe1306f483bb953cda9192ebe4d | nova           |                                  | default |                                           | nova@localhost           | True    |
| f12313666bc14422bda685eb649bf0a9 | placement      |                                  | default |                                           | placement@localhost      | True    |
| 16e844cc7aa24a70b97feec4ea5cd454 | neutron        |                                  | default |                                           | neutron@localhost        | True    |
| d0a7ba79556d4daa999f2dd15c102d9e | swift          |                                  | default |                                           | swift@localhost          | True    |
| c03f8b8c69e343fd895cc29a162b432e | gnocchi        |                                  | default |                                           | gnocchi@localhost        | True    |
| f7dc6d25dcf7470589214b89ba9759d2 | ceilometer     |                                  | default |                                           | ceilometer@localhost     | True    |
| 68992720af034a829b139b36f7a5107f | aodh           |                                  | default |                                           | aodh@localhost           | True    |
| 1cba533226f145af87e144c8d935ddc0 | demo           | f34b605e1d5b4ce2b1b8b17e0d16ab4b | default | User will be associated with Demo Project | demo@localhost           | True    |
| 64e6c93dc8174c419e2b33a213948619 | amit           |                                  | default |                                           | amit@localhost           | True    |
| 3f6b0b7c7b244bd9a38af98933d10eb6 | demo-sales-crm | 041a796d70964e28a8b1f79ac103fd0d | default | Demo Sales CRM User                       | demo-sales-crm@localhost | True    |
+----------------------------------+----------------+----------------------------------+---------+-------------------------------------------+--------------------------+---------+
[root@openstack ~(keystone_admin)]#

```


## Role Assignment
```
[root@openstack ~(keystone_admin)]# openstack role add --user demo-sales-crm --project demo-sales-crm member
[root@openstack ~(keystone_admin)]# openstack role assignment list --names
+---------------+------------------------+--------------------+------------------------+--------+--------+-----------+
| Role          | User                   | Group              | Project                | Domain | System | Inherited |
+---------------+------------------------+--------------------+------------------------+--------+--------+-----------+
| admin         | neutron@Default        |                    | services@Default       |        |        | False     |
| _member_      | demo@Default           |                    | demo@Default           |        |        | False     |
| admin         | nova@Default           |                    | services@Default       |        |        | False     |
| member        | demo-sales-crm@Default |                    | demo-sales-crm@Default |        |        | False     |
| admin         | cinder@Default         |                    | services@Default       |        |        | False     |
| admin         | admin@Default          |                    | admin@Default          |        |        | False     |
| admin         | aodh@Default           |                    | services@Default       |        |        | False     |
| admin         | glance@Default         |                    | services@Default       |        |        | False     |
| admin         | gnocchi@Default        |                    | services@Default       |        |        | False     |
| admin         | swift@Default          |                    | services@Default       |        |        | False     |
| admin         | placement@Default      |                    | services@Default       |        |        | False     |
| admin         | ceilometer@Default     |                    | services@Default       |        |        | False     |
| ResellerAdmin | ceilometer@Default     |                    | services@Default       |        |        | False     |
| _member_      |                        | demo-group@Default | demo@Default           |        |        | False     |
| admin         | admin@Default          |                    |                        |        | all    | False     |
+---------------+------------------------+--------------------+------------------------+--------+--------+-----------+
[root@openstack ~(keystone_admin)]#
```
