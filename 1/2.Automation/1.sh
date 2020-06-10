#!/bin/bash
set -x
#
# Assumptions:
# - Your AWS API key is alredy in ~/.aws/credentials
# - Your AWS config is already set up  in ~/.aws/config
#

provision () {
  #
  # To provision the AWS resources I will move into the terraform template
  # folder
  #
  cd "$PWD"/2.Tools/1.provision || echo "Error while moving to the target provision folder"
  ./terraform init -input=false
  ./terraform apply -input=false -auto-approve 

  #
  # Wait for the cloud init to finish installing the required packages
  #
  sleep 35
  echo "Please wait while provisioning your resources..."

  #
  # Catch up the elastic IP of the resource and then move the application
  # to the target instance
  #
  EIP=$(aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output=text)

  #
  # Let's move to the root folder and copy the application files
  #
  cd - || echo "Error while moving to previous PWD"   # Let's move to the root folder and copy the application files

  #
  # Copy the application to the target EIP and deploy the app
  #
  for i in $EIP; do scp ./1.Flask/hello.py admin@"$i":/home/admin; scp 2.Tools/1.provision/hello.sh admin@"$i":/home/admin; ssh admin@"$i" "sh hello.sh > /tmp/app.log 2>&1 &"; done
  echo "Application deployed and launched..."
}

#
# Configure the deployment
# $1: num_servers
# $2: server_size
#
config () {
  sed -i "s/TYPE/$1/g" 2.Tools/1.provision/variables.tf
  sed -i "s/MAX_SIZE/$2/g" 2.Tools/1.provision/variables.tf
  sed -i "s/MIN_SIZE/$2/g" 2.Tools/1.provision/variables.tf
}

if [ $# -lt 4 ]; then
  echo "Usage  : 1.sh [app] [environment] [num_servers] [server_size]"
  echo "Example: 1.sh web test 2 t2.micro"
else
  config "$4" "$3"
  provision
fi
