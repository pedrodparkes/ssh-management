## Description

This scriptset grabs existing AWS IAM-users and places they SSH-Deploy Public Keys in /home/ec2-user/.ssh/authorized_keys
For compatability with Ubuntu, edit import_users.sh and replace "ec2-user" with "ubuntu".

As a result all IAM-user's SSH Public keys will be placed in /home/ec2-user/.ssh/authorized_keys.
To stop user's access - deactivate IAM User's SSH Deploy Key.

ssh string:
```
ssh -i ~./ssh/id_rsa ec2-user@<servername>
```

## Requirements:
  EC2 instance must have access to IAM-users and keys.
  Create IAM role by CloudFormation template iam-role-importer.yaml

## Tested on Amazon Linux AMI and Ubuntu

## Installation:
```
vim /opt/import_users.sh
chmod 755 /opt/import_users.sh
vim /etc/cron.d/import_users
chmod 644 /etc/cron.d/import_users
```

## Delete all IAM users
Use <delete-all.sh> to remove all IAM users from your system
