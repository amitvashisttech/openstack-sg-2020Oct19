## Nova On CLI

Objective 1 : Scope amy/sales-crm.
```
Create a Keypair named amy-kp2 and store Private Key in file amy-kp2.pem.
Restrict access to this file.
```

Solution : 1 
```
[root@openstack ~(keystone_amy)]# oc keypair create  amy-kp2 > .ssh/amy-kp2.pem

[root@openstack ~(keystone_amy)]# oc keypair list
+---------+-------------------------------------------------+
| Name    | Fingerprint                                     |
+---------+-------------------------------------------------+
| amy-kp2 | 00:29:00:44:c6:41:93:ba:65:5f:a7:7d:f0:05:d6:c5 |
+---------+-------------------------------------------------+
[root@openstack ~(keystone_amy)]# chmod 400 .ssh/amy-kp2.pem


# Host-SSH Key - Injection

[root@openstack ~(keystone_amy)]# ssh-keygen -t rsa -b 1024
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): /root/.ssh/amy-kp3

[root@openstack ~(keystone_amy)]# 
[root@openstack ~(keystone_amy)]# oc keypair create --public-key .ssh/amy-kp3.pub  amy-kp3
+-------------+-------------------------------------------------+
| Field       | Value                                           |
+-------------+-------------------------------------------------+
| fingerprint | ee:8a:38:ba:45:e0:01:5d:7a:a6:eb:89:9c:b6:6c:e5 |
| name        | amy-kp3                                         |
| user_id     | 4d7189282cf94376a2e61fb8eafad529                |
+-------------+-------------------------------------------------+
[root@openstack ~(keystone_amy)]# oc keypair list
+---------+-------------------------------------------------+
| Name    | Fingerprint                                     |
+---------+-------------------------------------------------+
| amy-kp2 | 00:29:00:44:c6:41:93:ba:65:5f:a7:7d:f0:05:d6:c5 |
| amy-kp3 | ee:8a:38:ba:45:e0:01:5d:7a:a6:eb:89:9c:b6:6c:e5 |
+---------+-------------------------------------------------+
[root@openstack ~(keystone_amy)]#
```

Objective 2 : Scope admin/admin.
```
Create a new Public Flavor:
• Flavor Name: funky.flavor
• ID: 20
• VCPUs: 1
• RAM: 600
• Disk: 1
• Property: os_shutdown_timout=45
```
Solution : 2
```

[root@openstack ~(keystone_admin)]# oc flavor list
+----+-----------+-------+------+-----------+-------+-----------+
| ID | Name      |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+----+-----------+-------+------+-----------+-------+-----------+
| 1  | m1.tiny   |   512 |    1 |         0 |     1 | True      |
| 2  | m1.small  |  2048 |   20 |         0 |     1 | True      |
| 3  | m1.medium |  4096 |   40 |         0 |     2 | True      |
| 4  | m1.large  |  8192 |   80 |         0 |     4 | True      |
| 5  | m1.xlarge | 16384 |  160 |         0 |     8 | True      |
+----+-----------+-------+------+-----------+-------+-----------+
[root@openstack ~(keystone_admin)]# 

[root@openstack ~(keystone_admin)]# oc flavor create --id 20 --ram 600 --vcpus 1 --public --disk 1 --property os_shutdown_timout=45 funky.flavor
+----------------------------+-------------------------+
| Field                      | Value                   |
+----------------------------+-------------------------+
| OS-FLV-DISABLED:disabled   | False                   |
| OS-FLV-EXT-DATA:ephemeral  | 0                       |
| disk                       | 1                       |
| id                         | 20                      |
| name                       | funky.flavor            |
| os-flavor-access:is_public | True                    |
| properties                 | os_shutdown_timout='45' |
| ram                        | 600                     |
| rxtx_factor                | 1.0                     |
| swap                       |                         |
| vcpus                      | 1                       |
+----------------------------+-------------------------+
[root@openstack ~(keystone_admin)]#

```


Objective 3 : Scope lisa/crm-dev.
```
Modify Default Quotas for Project crm-dev:
• Cores: 5
• Key pairs: 5
• RAM: 2500
```

Solution : 3
```
[root@openstack ~(keystone_lisa)]# nova limits
+------+-----+-------+--------+------+----------------+
| Verb | URI | Value | Remain | Unit | Next_Available |
+------+-----+-------+--------+------+----------------+
+------+-----+-------+--------+------+----------------+
+--------------------+------+-------+
| Name               | Used | Max   |
+--------------------+------+-------+
| Cores              | 0    | 15    |
| Instances          | 0    | 10    |
| Keypairs           | -    | 100   |
| RAM                | 0    | 20480 |
| Server Meta        | -    | 128   |
| ServerGroupMembers | -    | 10    |
| ServerGroups       | 0    | 10    |
+--------------------+------+-------+
[root@openstack ~(keystone_lisa)]# oc quota set --ram 2500 --cores 5 --key-pairs 5 crm-dev
[root@openstack ~(keystone_lisa)]# nova limits
+------+-----+-------+--------+------+----------------+
| Verb | URI | Value | Remain | Unit | Next_Available |
+------+-----+-------+--------+------+----------------+
+------+-----+-------+--------+------+----------------+
+--------------------+------+------+
| Name               | Used | Max  |
+--------------------+------+------+
| Cores              | 0    | 5    |
| Instances          | 0    | 10   |
| Keypairs           | -    | 5    |
| RAM                | 0    | 2500 |
| Server Meta        | -    | 128  |
| ServerGroupMembers | -    | 10   |
| ServerGroups       | 0    | 10   |
+--------------------+------+------+
[root@openstack ~(keystone_lisa)]#

```


Objective 4 : Scope amy/sales-crm.
```
Launch a New Instance from Image:
• Name: insta1
• Flavor: funky.flavor
• Image: system-4.0
• Key pair: amy-kp2
• Network: public
• Add Security Group sales-crm-sg2 to Instance insta1.
```

Solution 4:
```
[root@openstack ~(keystone_amy)]# oc security group list
+--------------------------------------+---------------+------------------------+----------------------------------+------+
| ID                                   | Name          | Description            | Project                          | Tags |
+--------------------------------------+---------------+------------------------+----------------------------------+------+
| c14252dd-454b-457d-bc9b-8ec145f2382f | default       | Default security group | 1bf0aa2c1e314024aac0a84f1e3782cb | []   |
| e2897843-23d8-4cc3-8b87-c520774d2669 | sales-crm-sg2 | sales-crm-sg2          | 1bf0aa2c1e314024aac0a84f1e3782cb | []   |
+--------------------------------------+---------------+------------------------+----------------------------------+------+
[root@openstack ~(keystone_amy)]# oc security group create sales-crm-sg2
oc security group rule create sales-crm-sg2 --protocol icmp
oc security group rule create sales-crm-sg2 --protocol tcp --dst-port 22:22

```

Objective 5: Scope amy/sales-crm.
```
List available Networks and note UUID of Network public.
List Network Name Spaces and identify one associated to Network public.
Using ip netns exec, login to Instance insta1 using SSH and Private Key amy-kp2.

 • Change the Root Password 
 • Create a Dir : /openstack-demo
 • Create a file : echo "Welcome to Openstack Demo " > /openstack-demo/hello.txt

```

Solution 5: 
```
[root@openstack ~(keystone_amy)]# oc
(openstack) image list
+--------------------------------------+------------+--------+
| ID                                   | Name       | Status |
+--------------------------------------+------------+--------+
| 85f37fa5-b467-4ca8-9fad-8a0e29de8800 | system-4.0 | active |
+--------------------------------------+------------+--------+
(openstack) flavor list
+----+--------------+-------+------+-----------+-------+-----------+
| ID | Name         |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+----+--------------+-------+------+-----------+-------+-----------+
| 1  | m1.tiny      |   512 |    1 |         0 |     1 | True      |
| 10 | crm.web      |  1024 |    2 |         0 |     1 | False     |
| 2  | m1.small     |  2048 |   20 |         0 |     1 | True      |
| 20 | funky.flavor |   600 |    1 |         0 |     1 | True      |
| 3  | m1.medium    |  4096 |   40 |         0 |     2 | True      |
| 4  | m1.large     |  8192 |   80 |         0 |     4 | True      |
| 5  | m1.xlarge    | 16384 |  160 |         0 |     8 | True      |
+----+--------------+-------+------+-----------+-------+-----------+
(openstack) network list
+--------------------------------------+----------+--------------------------------------+
| ID                                   | Name     | Subnets                              |
+--------------------------------------+----------+--------------------------------------+
| 6c8f3c9d-4196-4da8-86f8-4d333d3d76b8 | external | 6fe3e09f-0122-4bd7-acf1-b90bc1656fa6 |
+--------------------------------------+----------+--------------------------------------+
(openstack) network list
+--------------------------------------+-------------+--------------------------------------+
| ID                                   | Name        | Subnets                              |
+--------------------------------------+-------------+--------------------------------------+
| 2db51213-65b2-4442-8647-ff50f8e6e097 | pvt-network | 4306891b-1d3a-4059-93fc-c9e9de0eda3d |
| 6c8f3c9d-4196-4da8-86f8-4d333d3d76b8 | external    | 6fe3e09f-0122-4bd7-acf1-b90bc1656fa6 |
+--------------------------------------+-------------+--------------------------------------+
(openstack) keypair list
+---------+-------------------------------------------------+
| Name    | Fingerprint                                     |
+---------+-------------------------------------------------+
| amy-kp2 | 00:29:00:44:c6:41:93:ba:65:5f:a7:7d:f0:05:d6:c5 |
| amy-kp3 | ee:8a:38:ba:45:e0:01:5d:7a:a6:eb:89:9c:b6:6c:e5 |
+---------+-------------------------------------------------+
(openstack) security group list
+--------------------------------------+---------------+------------------------+----------------------------------+------+
| ID                                   | Name          | Description            | Project                          | Tags |
+--------------------------------------+---------------+------------------------+----------------------------------+------+
| c14252dd-454b-457d-bc9b-8ec145f2382f | default       | Default security group | 1bf0aa2c1e314024aac0a84f1e3782cb | []   |
| e2897843-23d8-4cc3-8b87-c520774d2669 | sales-crm-sg2 | sales-crm-sg2          | 1bf0aa2c1e314024aac0a84f1e3782cb | []   |
+--------------------------------------+---------------+------------------------+----------------------------------+------+
(openstack) server create --image system-4.0 --flavor funky.flavor --key-name amy-kp2 --security-group default --security-group sales-crm-sg2 --nic net-id="2db51213-65b2-4442-8647-ff50f8e6e097" insta1
+-----------------------------+---------------------------------------------------+
| Field                       | Value                                             |
+-----------------------------+---------------------------------------------------+
| OS-DCF:diskConfig           | MANUAL                                            |
| OS-EXT-AZ:availability_zone |                                                   |
| OS-EXT-STS:power_state      | NOSTATE                                           |
| OS-EXT-STS:task_state       | scheduling                                        |
| OS-EXT-STS:vm_state         | building                                          |
| OS-SRV-USG:launched_at      | None                                              |
| OS-SRV-USG:terminated_at    | None                                              |
| accessIPv4                  |                                                   |
| accessIPv6                  |                                                   |
| addresses                   |                                                   |
| adminPass                   | tVuaaWEsUT4d                                      |
| config_drive                |                                                   |
| created                     | 2020-10-21T12:44:03Z                              |
| flavor                      | funky.flavor (20)                                 |
| hostId                      |                                                   |
| id                          | 08f20702-a1aa-4171-bcbb-58e9a874f2d7              |
| image                       | system-4.0 (85f37fa5-b467-4ca8-9fad-8a0e29de8800) |
| key_name                    | amy-kp2                                           |
| name                        | insta1                                            |
| progress                    | 0                                                 |
| project_id                  | 1bf0aa2c1e314024aac0a84f1e3782cb                  |
| properties                  |                                                   |
| security_groups             | name='c14252dd-454b-457d-bc9b-8ec145f2382f'       |
|                             | name='e2897843-23d8-4cc3-8b87-c520774d2669'       |
| status                      | BUILD                                             |
| updated                     | 2020-10-21T12:44:03Z                              |
| user_id                     | 4d7189282cf94376a2e61fb8eafad529                  |
| volumes_attached            |                                                   |
+-----------------------------+---------------------------------------------------+
(openstack) server list
+--------------------------------------+--------+--------+----------+------------+--------------+
| ID                                   | Name   | Status | Networks | Image      | Flavor       |
+--------------------------------------+--------+--------+----------+------------+--------------+
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | BUILD  |          | system-4.0 | funky.flavor |
+--------------------------------------+--------+--------+----------+------------+--------------+
(openstack) server list
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| ID                                   | Name   | Status | Networks                | Image      | Flavor       |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | ACTIVE | pvt-network=10.20.1.193 | system-4.0 | funky.flavor |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
(openstack) server list
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| ID                                   | Name   | Status | Networks                | Image      | Flavor       |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | ACTIVE | pvt-network=10.20.1.193 | system-4.0 | funky.flavor |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
(openstack)

[root@openstack ~(keystone_amy)]# oc server list
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| ID                                   | Name   | Status | Networks                | Image      | Flavor       |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | ACTIVE | pvt-network=10.20.1.193 | system-4.0 | funky.flavor |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
[root@openstack ~(keystone_amy)]# oc network list
+--------------------------------------+-------------+--------------------------------------+
| ID                                   | Name        | Subnets                              |
+--------------------------------------+-------------+--------------------------------------+
| 2db51213-65b2-4442-8647-ff50f8e6e097 | pvt-network | 4306891b-1d3a-4059-93fc-c9e9de0eda3d |
| 6c8f3c9d-4196-4da8-86f8-4d333d3d76b8 | external    | 6fe3e09f-0122-4bd7-acf1-b90bc1656fa6 |
+--------------------------------------+-------------+--------------------------------------+
[root@openstack ~(keystone_amy)]#

[root@openstack ~(keystone_amy)]# ip netns exec ovnmeta-422d0375-438b-49db-b870-615b50eacd45 ping -c 2 10.20.1.193
PING 10.20.1.193 (10.20.1.193) 56(84) bytes of data.
64 bytes from 10.20.1.193: icmp_seq=1 ttl=64 time=5.86 ms
64 bytes from 10.20.1.193: icmp_seq=2 ttl=64 time=1.82 ms


[root@openstack ~(keystone_amy)]# ip netns exec ovnmeta-422d0375-438b-49db-b870-615b50eacd45 ssh -i /root/.ssh/amy-kp2.pem cirros@10.20.1.193

```


Objective 6 : Scope amy/sales-crm.

```
Shutdown the Instance insta1.
Create an Instance Snapshot of Instance insta1, name it insta1-snap.
Launch a New Instance from Snapshot:
• Name: insta2
• Image: insta1-snap
• Flavor: funky-flavor
• Network: public
• Security Group: default and sales-crm-sg2
Login to Instance insta2, using ip netns exec, SSH and Private Key amy-kp2.
Ping openstack.org.
Shutdown the Instance insta2.
```

Solution 6: 
```
[root@openstack ~(keystone_amy)]# oc server list
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| ID                                   | Name   | Status | Networks                | Image      | Flavor       |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | ACTIVE | pvt-network=10.20.1.193 | system-4.0 | funky.flavor |
+--------------------------------------+--------+--------+-------------------------+------------+--------------+
[root@openstack ~(keystone_amy)]# oc server stop insta1
[root@openstack ~(keystone_amy)]# oc server list
+--------------------------------------+--------+---------+-------------------------+------------+--------------+
| ID                                   | Name   | Status  | Networks                | Image      | Flavor       |
+--------------------------------------+--------+---------+-------------------------+------------+--------------+
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | SHUTOFF | pvt-network=10.20.1.193 | system-4.0 | funky.flavor |
+--------------------------------------+--------+---------+-------------------------+------------+--------------+
[root@openstack ~(keystone_amy)]# oc server image create --name insta1-snap insta1

[root@openstack ~(keystone_amy)]# oc image list
+--------------------------------------+-------------+--------+
| ID                                   | Name        | Status |
+--------------------------------------+-------------+--------+
| 158d8344-2aea-4ff7-859c-29d6f9687a2c | insta1-snap | active |
| 85f37fa5-b467-4ca8-9fad-8a0e29de8800 | system-4.0  | active |
+--------------------------------------+-------------+--------+
[root@openstack ~(keystone_amy)]# 
[root@openstack ~(keystone_amy)]# oc server create --image insta1-snap --flavor funky.flavor --key-name amy-kp2 --security-group default --security-group sales-crm-sg2 --nic net-id="2db51213-65b2-4442-8647-ff50f8e6e097" insta2

[root@openstack ~(keystone_amy)]# oc server list
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
| ID                                   | Name   | Status  | Networks                | Image       | Flavor       |
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
| 338e4f79-7321-45ac-a8f1-372171ad7f39 | insta2 | BUILD   |                         | insta1-snap | funky.flavor |
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | SHUTOFF | pvt-network=10.20.1.193 | system-4.0  | funky.flavor |
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
[root@openstack ~(keystone_amy)]# oc server list
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
| ID                                   | Name   | Status  | Networks                | Image       | Flavor       |
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
| 338e4f79-7321-45ac-a8f1-372171ad7f39 | insta2 | ACTIVE  | pvt-network=10.20.1.178 | insta1-snap | funky.flavor |
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | SHUTOFF | pvt-network=10.20.1.193 | system-4.0  | funky.flavor |
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
[root@openstack ~(keystone_amy)]#
```


Objective 7.
```
Disable Compute Host openstack for maintenance using OpenStack Client. Check up Status of
nova-compute Service on Host openstack.
Enable Compute Host openstack using the Horizon Dashboard.
List all Compute Hosts and their Services.
Display Hosts Statistics for openstack.
Analyse Diagnostic Data for selected Instance.
Monitor Usage Statistics for all Projects in Horizon and on Command Line.
```

Solution 7: 
```
[root@openstack ~(keystone_admin)]# oc compute service set --disable --disable-reason "Maintance Mode" openstack.example.com nova-compute
[root@openstack ~(keystone_admin)]# openstack host list
+-----------------------+-----------+----------+
| Host Name             | Service   | Zone     |
+-----------------------+-----------+----------+
| openstack.example.com | conductor | internal |
| openstack.example.com | scheduler | internal |
+-----------------------+-----------+----------+
[root@openstack ~(keystone_admin)]# oc compute service list
+----+----------------+-----------------------+----------+----------+-------+----------------------------+
| ID | Binary         | Host                  | Zone     | Status   | State | Updated At                 |
+----+----------------+-----------------------+----------+----------+-------+----------------------------+
|  2 | nova-conductor | openstack.example.com | internal | enabled  | up    | 2020-10-21T13:03:31.000000 |
|  3 | nova-scheduler | openstack.example.com | internal | enabled  | up    | 2020-10-21T13:03:34.000000 |
|  4 | nova-compute   | openstack.example.com | nova     | disabled | up    | 2020-10-21T13:03:34.000000 |
+----+----------------+-----------------------+----------+----------+-------+----------------------------+
[root@openstack ~(keystone_admin)]# 

[root@openstack ~(keystone_admin)]# oc compute service set --enable  openstack.example.com nova-compute

[root@openstack ~(keystone_admin)]# oc compute service list
+----+----------------+-----------------------+----------+---------+-------+----------------------------+
| ID | Binary         | Host                  | Zone     | Status  | State | Updated At                 |
+----+----------------+-----------------------+----------+---------+-------+----------------------------+
|  2 | nova-conductor | openstack.example.com | internal | enabled | up    | 2020-10-21T13:05:31.000000 |
|  3 | nova-scheduler | openstack.example.com | internal | enabled | up    | 2020-10-21T13:05:34.000000 |
|  4 | nova-compute   | openstack.example.com | nova     | enabled | up    | 2020-10-21T13:05:34.000000 |
+----+----------------+-----------------------+----------+---------+-------+----------------------------+
[root@openstack ~(keystone_admin)]# oc server list




[root@openstack ~(keystone_amy)]# oc server list
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
| ID                                   | Name   | Status  | Networks                | Image       | Flavor       |
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
| 338e4f79-7321-45ac-a8f1-372171ad7f39 | insta2 | ACTIVE  | pvt-network=10.20.1.178 | insta1-snap | funky.flavor |
| 08f20702-a1aa-4171-bcbb-58e9a874f2d7 | insta1 | SHUTOFF | pvt-network=10.20.1.193 | system-4.0  | funky.flavor |
+--------------------------------------+--------+---------+-------------------------+-------------+--------------+
[root@openstack ~(keystone_amy)]# 

[root@openstack ~(keystone_lisa)]# oc usage list
Usage from 2020-09-23 to 2020-10-22:
+-----------+---------+--------------+-----------+---------------+
| Project   | Servers | RAM MB-Hours | CPU Hours | Disk GB-Hours |
+-----------+---------+--------------+-----------+---------------+
| sales-crm |       2 |       365.78 |      0.61 |          0.61 |
| demo      |       2 |      7610.84 |     14.86 |         14.86 |
+-----------+---------+--------------+-----------+---------------+
[root@openstack ~(keystone_lisa)]#

```
