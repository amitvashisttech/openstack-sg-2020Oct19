# Volume Management in Dashboard

Objective 1: Scope demo/demo.

```
Create a New Volume:
• Name: demo-vol1
• Description: Database Volume for demo Project
• Volume Source: empty volume
• Type: no volume type
• Size: 1
Start the Instance test-vm1.
Attach the Volume demo-vol1 to Instance test-vm1.
```

Objective 2: Scope demo/demo.
```
Login to Console of Instance test-vm1.
Create ext3 type filesystem on newly attached Volume:
sudo mkfs.ext3 /dev/vdb
Mount the Volume:
sudo mount /dev/vdb /mnt
Create a file with Instance "stamp":
hostname >> /mnt/file.txt
date >> /mnt/file.txt
Verify the file:
pg /mnt/file.txt
Unmount the Volume and Detach from the Instance.
```

Objective 3: Scope: demo/demo.
```
Create a New Snapshot demo-vol1-snap1 of the Volume demo-vol1.
Create a New Volume from the Snapshot:
• Name: demo-vol2
• Volume Source: Snapshot
• Snapshot Source: demo-vol1-snap1
```

Objective 4: Scope lisa/crm-dev.
```
Create a Volume Type lvm-2 to enable Volume scheduling to Backend LVM-2.
```

Objective 5: Scope lisa/crm-dev.
```
Change Storage Quota snapshots to 50 for Project crm-dev.
```

Objective 6:  Scope demo/demo.

```
Create a New Volume from Image:
• Name: boot-vol3
• Description: Boot Volume Created from Image system-3.5
• Volume Source: image
• Use image as source: system-3.5
```
```
Launch a New Instance from Bootable Volume:
• Name: persistent-boot-vol
• Description: Instance Created from Bootable Volume boot-vol3
• Boot Source: Volume
• Flavor: m1.tiny
• Network: private
• Security Groups: default and demo_sg
```
```
Attach a Volume demo-vol2 to Instance persistent-boot-vol and mount it to /mnt.

Create an Instance "stamp" in the file /mnt/file.txt:
hostname >> /mnt/file.txt
date >> /mnt/file.txt
Verify the file:
pg /mnt/file.txt
Copy the file to Instance Volume:
cp /mnt/file.txt ~/history.txt
Unmount the Volume and Detach from the Instance.
Shutdown the Instance.
```

Objective 7: Scope: demo/demo.
```
Create a Volume Transfer for demo-vol2.
Note down Transfer ID and Authorization ID.
```

Objective 8: Scope: lisa/crm-dev.
```
Accept the Volume Transfer, using the Transfer ID and Authorization ID noted in Objective 7.
```
