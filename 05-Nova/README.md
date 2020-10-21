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

