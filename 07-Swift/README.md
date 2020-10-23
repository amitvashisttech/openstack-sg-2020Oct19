# Swift & Horizon

Objective 1: Scope lisa/admin.

```
Create a Public Container named sales-ko-photos.
Upload an arbitrary text file to sales-ko-photos Container.
Download the file to /tmp directory. Verify the content.
```


# Managing Object Storage in Command Line Environment
Objective 1: Scope amy/sales-crm.
```
Create a New Container named sales-bucket and grant read and write access to all Users
in Project sales-crm.
Upload a file labs/red_prompt.sh to sales-bucket.
```

Objective 2: Scope lisa/admin.
```
Create a New Container named public-container and grant everyone rights to list Container,
read and download Objects.
Upload labs/yellow_prompt.sh to public-container.
Change current directory to /tmp and download all objects from public_container.
```

Objective 3: Scope amy/sales-crm.
```
Create a file:
hostname >> testing
date >> testing
Upload a file testing to Container sales-bucket and set it to expire after 60 seconds.
Try to download Object testing after one minute.
```

Objective 4: Scope amy/sales-crm.
```
Determine Unix Epoch time for tomorrow at noon.
Upload testing file to public-container and set it to expire tomorrow at noon.
Verify Object expiration time.
Remove Expiration Date on Object testing in Container public-container.
```
