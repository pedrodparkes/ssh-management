# SSH-key-management

Set of scripts to manage SSH access on AWS and vmWare VMs.
	*each subfolder has own README.md

### ./aws-access-by-ec2-user/
Grabs AWS IAM-users and places they SSH "Deploy Public Keys" in 
```
/home/ec2-user/.ssh/authorized_keys
```



### ./aws-access-by-iamusername/
Grab existing AWS IAM-users, add them as system users 
```
<user.name>@<domain.com> = <user.name>
```
and place User's SSH Deploy Public Keys in 
```
/home/<user.name>/.ssh/authorized_keys
```



### ./vmware-vm-access-by-pubkey/
Copy your PublicKey to multiple running VMware VMs.# ssh-management
