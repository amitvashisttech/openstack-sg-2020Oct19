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

