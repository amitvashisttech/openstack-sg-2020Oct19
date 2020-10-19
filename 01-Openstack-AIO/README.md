# Setting out OpenStack Lab Env with Vagrant & Virtul Box 


## Please the following Repo via git bash utils
```
git clone https://github.com/amitvashisttech/openstack-sg-2020Oct19.git

```

## Switch to 01-Openstack-AIO Dir. 
```
cd openstack-sg-2020Oct19/01-Openstack-AIO/
ls Vagrantfile
```

## Provision CentOS 7 VM with Vagrant util: 
```
vagrant.exe up 
```

## Check Status of newly provisioned VM
```
vagrant.exe status
```

## In order to get inside the VM : 
```
vagrant.exe ssh <nameofyourVM>
```



## Installing Net-Tools
```
  yum install net-tools -y
  netstat -tulnp
```

## Disable & Remove NetworkManger
```
   systemctl disable firewalld
   systemctl stop firewalld
   systemctl disable NetworkManager
   systemctl stop NetworkManager
   systemctl mask NetworkManager
   yum remove NetworkManager NetworkManager-libnm
```

## Setting SELinux in Permissive Mode
```
   getenforce
   setenforce 0
   getenforce
   cat /etc/selinux/config
   sed -i "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config
   cat /etc/selinux/config
```

## Installing RDO Based Packstack Packages
```
   hostname
   yum install ntpdate -y
   yum install -y https://www.rdoproject.org/repos/rdo-release.rpm
   yum install -y centos-release-openstack-train
   yum update -y
   yum install openstack-packstack -y 
```
