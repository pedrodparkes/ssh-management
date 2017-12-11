## Description

This scriptset grabs existing AWS IAM-users, adds them as system users ( <user.name>@<domain.com> = <user.name> ) 
and places User's SSH Deploy Public Keys in /home/<user.name>/.ssh/authorized_keys
This script is compatible with DUO MFA authentication (http://duo.com)

As a result all IAM-user's SSH Public keys will be placed in /home/<user.name>/.ssh/authorized_keys.
To stop user's access - deactivate IAM User's SSH Deploy Key.

## ssh string:
```
ssh -i ~./ssh/id_rsa <user.name>@<servername>
```

## Requirements:
  EC2 instance must have access to IAM-users and keys.
  Create IAM role by CloudFormation template iam-role-importer.yaml

## Tested on Amazon Linux AMI and Ubuntu Linux

## Installation:
```
vim /opt/import_users.sh
chmod 755 /opt/import_users.sh
vim /etc/cron.d/import_users
chmod 644 /etc/cron.d/import_users
```

## Delete IAM Users
Use <delete-all.sh> to remove all IAM users from your system
