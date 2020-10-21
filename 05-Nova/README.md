# Nova Introduction

## Nova in Horizon Dashboard

Objective 0 : Scope: demo/demo.
```
Createa a Private Network.
• Network Name: demo-net
• Subnet Name : semo-subnet
• Network Address: 10.20.2.0/24
• Gateway IP: 10.20.2.1
• Enable DHCP : True
• Allocation Pools: 10.20.2.2,10.20.2.240
```


Objective 1 : Scope: lisa/sales-crm.
```
Create a New Keypair:
• Keypair Name: scrm-keypair1
• Save Private Key to local file named scrm-keypair1.pem
```

Objective 2 : Scope: lisa/admin.
```
Create a New Public Flavor:
• Flavor Name: crm.web
• ID: 10
• VCPUs: 1
• RAM (MB): 1024
• Root Disk (GB): 2
• Ephemeral Disk (GB): 0
• Swap Disk (GB): 0
• RX/TX Factor: 1
```

Objective 3: Scope: lisa/admin.
```
Modify Flavor Access to Projects: crm-dev and sales-crm.
```

Objective 4 : Scope: admin/admin.
```
Modify Default Quotas:
• RAM (MB): 20480
• VCPUs: 15
• Volumes: 15
```

Objective 5: Scope: demo/demo.
```
Create a New Instance:
• Instance Name: test-vm1
• Boot Source: Image
• Delete Volume on Instance Delete: Yes
• Image Name: system-3.5
• Flavor Name: m1.tiny
• Network: private
• Security Group: add demo-sg
```

Objective 6: Scope: demo/demo.
```
Login to Instance test-vm1 with Console, ping openstack.org.
 • Change the Root Password 
 • Create a Dir : /openstack-demo
 • Create a file : echo "Welcome to Openstack Demo " > /openstack-demo/hello.txt
```

Objective 7: Scope: demo/demo.
```
Shutdown the Instance test-vm1.
```

Objective 8 : Scope: demo/demo.
```
Create a Snapshot of the Instance test-vm1:
• Snapshot Name: snap1
```

Objective 9: Scope: demo/demo.
```
Create Keypair demo-kp1 in Project demo.

Create a New Instance from the Instance Snapshot:
• Snapshot Name: snap1
• Instance Name: from-snap1
• Flavor: m1.tiny
• Network: private
• Security Group: add demo-sg
• Key Pair: demo-kp1

Login to Instance Console.
Ping <test-vm1>.
Shutdown the Instance from-snap1.
```



## Nova On CLI

Objective 1 : Scope amy/sales-crm.
```
Create a Keypair named amy-kp2 and store Private Key in file amy-kp2.pem.
Restrict access to this file.
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

Objective 3 : Scope lisa/crm-dev.
```
Modify Default Quotas for Project crm-dev:
• Cores: 5
• Key pairs: 5
• RAM: 2500
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

Objective 5: Scope amy/sales-crm.
```
List available Networks and note UUID of Network public.
List Network Name Spaces and identify one associated to Network public.
Using ip netns exec, login to Instance insta1 using SSH and Private Key amy-kp2.

 • Change the Root Password 
 • Create a Dir : /openstack-demo
 • Create a file : echo "Welcome to Openstack Demo " > /openstack-demo/hello.txt

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
