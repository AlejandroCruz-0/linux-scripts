#!/bin/bash

readarray -t hosts < <(cat IP-LIST)
declare -p hosts

#env variable
USER=$USER_ACCOUNT
SCRIPT=$SCRIPT_NAME
PASS=$SECRET_PASS

#Convert script to base64
SCRIPT=$(base64 -w0 $SCRIPT)

for host in "${hosts[@]}"
do

sshpass -p$PASS ssh -o ConnectTimeout=10 $USER@$host "echo $SCRIPT | base64 -d | bash"

if [[ $? -ne 0 ]];then
echo "$host" >> NON-RESPONSIVE-IP
continue
fi

done
