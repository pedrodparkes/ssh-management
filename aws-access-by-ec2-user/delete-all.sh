#!/bin/bash
aws iam list-users --query "Users[].[UserName]" --output text | sed 's/@.*//' | while read User; do userdel $User;  done;
