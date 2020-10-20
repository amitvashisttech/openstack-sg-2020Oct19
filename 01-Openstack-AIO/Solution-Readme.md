## Solution : Lab3 

Domain Creations: Objective 4
```
[root@openstack ~(keystone_admin)]# openstack domain list
+---------+---------+---------+--------------------+
| ID      | Name    | Enabled | Description        |
+---------+---------+---------+--------------------+
| default | Default | True    | The default domain |
+---------+---------+---------+--------------------+
```
```
[root@openstack ~(keystone_admin)]# openstack domain create --description "Domain for German Subsidiary Projects" german-sub
+-------------+---------------------------------------+
| Field       | Value                                 |
+-------------+---------------------------------------+
| description | Domain for German Subsidiary Projects |
| enabled     | True                                  |
| id          | 60660d4ca2194c6c9c96481c30034ffd      |
| name        | german-sub                            |
| options     | {}                                    |
| tags        | []                                    |
+-------------+---------------------------------------+
```
```
[root@openstack ~(keystone_admin)]# openstack domain list
+----------------------------------+------------+---------+---------------------------------------+
| ID                               | Name       | Enabled | Description                           |
+----------------------------------+------------+---------+---------------------------------------+
| 60660d4ca2194c6c9c96481c30034ffd | german-sub | True    | Domain for German Subsidiary Projects |
| default                          | Default    | True    | The default domain                    |
+----------------------------------+------------+---------+---------------------------------------+
[root@openstack ~(keystone_admin)]#
```







Objective 5 : Create a New Project in non-default domain:
```

[root@openstack ~(keystone_admin)]# openstack project create --description "R&D Project for German Subsidiary" --domain german-sub german-rnd
+-------------+-----------------------------------+
| Field       | Value                             |
+-------------+-----------------------------------+
| description | R&D Project for German Subsidiary |
| domain_id   | 60660d4ca2194c6c9c96481c30034ffd  |
| enabled     | True                              |
| id          | 4dea03db66c6452286700eb093c59260  |
| is_domain   | False                             |
| name        | german-rnd                        |
| options     | {}                                |
| parent_id   | 60660d4ca2194c6c9c96481c30034ffd  |
| tags        | []                                |
+-------------+-----------------------------------+
[root@openstack ~(keystone_admin)]#
```

Objective 6 : Create a New User in non-default domain:
```
[root@openstack ~(keystone_admin)]# openstack user create --project german-rnd --password-prompt --email "toby@localhost" --description "Demo CRM Dev User" --enable toby --domain german-sub
User Password:
Repeat User Password:
+---------------------+----------------------------------+
| Field               | Value                            |
+---------------------+----------------------------------+
| default_project_id  | 4dea03db66c6452286700eb093c59260 |
| description         | Demo CRM Dev User                |
| domain_id           | 60660d4ca2194c6c9c96481c30034ffd |
| email               | toby@localhost                   |
| enabled             | True                             |
| id                  | 9a38c219652d4ef8aa62971e37416b74 |
| name                | toby                             |
| options             | {}                               |
| password_expires_at | None                             |
+---------------------+----------------------------------+
[root@openstack ~(keystone_admin)]#
```
```
[root@openstack ~(keystone_admin)]# openstack domain list
+----------------------------------+------------+---------+---------------------------------------+
| ID                               | Name       | Enabled | Description                           |
+----------------------------------+------------+---------+---------------------------------------+
| 60660d4ca2194c6c9c96481c30034ffd | german-sub | True    | Domain for German Subsidiary Projects |
| default                          | Default    | True    | The default domain                    |
+----------------------------------+------------+---------+---------------------------------------+
[root@openstack ~(keystone_admin)]#
```

Objective 7: Create a New Role in Default domain:
```
[root@openstack ~(keystone_admin)]# openstack role add --user amy --project sales-crm ops
```
```
[root@openstack ~(keystone_admin)]# openstack role assignment list --user amy --project sales-crm
+----------------------------------+----------------------------------+-------+----------------------------------+--------+--------+-----------+
| Role                             | User                             | Group | Project                          | Domain | System | Inherited |
+----------------------------------+----------------------------------+-------+----------------------------------+--------+--------+-----------+
| 95b576db02e6491499e0aed4fbb25822 | d4039774ffbf46e9a4b916ac34660412 |       | 56b98f2d146c495894a9f853dd061b7e |        |        | False     |
| 9b15ddbbd2b0439d97d7e5de5715ecac | d4039774ffbf46e9a4b916ac34660412 |       | 56b98f2d146c495894a9f853dd061b7e |        |        | False     |
+----------------------------------+----------------------------------+-------+----------------------------------+--------+--------+-----------+
[root@openstack ~(keystone_admin)]#
```
```
[root@openstack ~(keystone_admin)]# openstack role assignment list --user amy --project sales-crm --names
+----------+-------------+-------+-------------------+--------+--------+-----------+
| Role     | User        | Group | Project           | Domain | System | Inherited |
+----------+-------------+-------+-------------------+--------+--------+-----------+
| _member_ | amy@Default |       | sales-crm@Default |        |        | False     |
| ops      | amy@Default |       | sales-crm@Default |        |        | False     |
+----------+-------------+-------+-------------------+--------+--------+-----------+
[root@openstack ~(keystone_admin)]#
```

Objective 8: Create a Group in Default domain:
```
[root@openstack ~(keystone_admin)]# openstack group create --description "Developers" developers
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | Developers                       |
| domain_id   | default                          |
| id          | e6ed7986467f4057a9b5643ce23fc772 |
| name        | developers                       |
+-------------+----------------------------------+
[root@openstack ~(keystone_admin)]#
```
```
[root@openstack ~(keystone_admin)]# openstack group add user developers john
```


Objective 9: Create a group in non-default domain:
```
[root@openstack ~(keystone_admin)]# openstack group create --description "German Admins" admins --domain german-sub
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | German Admins                    |
| domain_id   | 60660d4ca2194c6c9c96481c30034ffd |
| id          | b0cf929df96c471e8ec44d58618c56ba |
| name        | admins                           |
+-------------+----------------------------------+
[root@openstack ~(keystone_admin)]#
```
```
[root@openstack ~(keystone_admin)]# openstack group add user admins toby --group-domain german-sub --user-domain german-sub
```

Objective 10: Create a New Service in Service Catalog:
```
[root@openstack ~(keystone_admin)]# openstack service create --name ceilometer2 --description "Telemetry" metering
```
```
[root@openstack ~(keystone_admin)]# openstack service list
```

Objective 11 : Create New Service Endpoints for Service Type metering in Region RegionOne:
```
[root@openstack ~(keystone_admin)]#  openstack endpoint create --region RegionOne ceilometer2 internal http://controller:8777
[root@openstack ~(keystone_admin)]#  openstack endpoint create --region RegionOne ceilometer2 public http://controller:8777
[root@openstack ~(keystone_admin)]#  openstack endpoint create --region RegionOne ceilometer2 admin http://controller:8777
```

