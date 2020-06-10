#!/bin/bash
#
# Assumptions:
# - Your AWS API key is alredy in ~/.aws/credentials
# - Your AWS config is already set up  in ~/.aws/config
#

grant () {
  #
  # $1: vpc id 
  # $2: user id 
  # $3: public ssh key
  #
  for ip in $(aws ec2 describe-instances --filters "Name=vpc-id, Values=$1" --query "Reservations[*].Instances[*].PrivateIpAddress" --output text); do ssh "$ip" "adduser $2"; done
  for ip in $(aws ec2 describe-instances --filters "Name=vpc-id, Values=$1" --query "Reservations[*].Instances[*].PrivateIpAddress" --output text); do ssh "$ip" "sudo su - $2 -c 'echo $3 >> /home/$2/.ssh/authorized_keys'"; done
}

revoke () {
  #
  # Sorry for using userdel -f, used for simplicity
  # $1: vpc id
  # $2: user id
  #
  for ip in $(aws ec2 describe-instances --filters "Name=vpc-id, Values=$1" --query "Reservations[*].Instances[*].PrivateIpAddress" --output text); do ssh "$ip" "sudo userdel -f $2"; done
}

#
# $1: action
# $2: vpc id
# $3: user id
# $4: public ssh key
#
#
# It requires a lot of validation for the parameters but I will expect the user to send the proper ones
#
if [ $# -lt 4 ]; then
  echo "Usage: 1.sh [grant/revoke] [vpc id] [user id] [\"public ssh key\"]"
else
  if [ "$1" == "grant" ]
  then
    grant "$2" "$3" "$4"
  elif [ "$1" == "revoke" ]
  then
    revoke "$2" "$3"
  fi
fi
