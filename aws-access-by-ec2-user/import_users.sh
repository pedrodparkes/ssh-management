#!/bin/bash
# /opt/import_users.sh
#  mode: '000755'
#  owner: root
#  group: root
rm -f /home/ec2-user/.ssh/authorized_keys;aws iam list-users --query "Users[].[UserName]" --output text | while read User; do aws iam list-ssh-public-keys --user-name "$User" --query "SSHPublicKeys[?Status == 'Active'].[SSHPublicKeyId]" --output text | while read KeyId; do aws iam get-ssh-public-key --user-name "$User" --ssh-public-key-id "$KeyId" --encoding SSH --query "SSHPublicKey.SSHPublicKeyBody" --output text >> /home/ec2-user/.ssh/authorized_keys; done; done;
