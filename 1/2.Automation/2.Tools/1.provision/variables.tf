variable "prefix" {
  default = "emerson-posadas"
}

variable "vpc" {
  default = "vpc-1098737a" # Default vpc
}

variable "subnet" {
  default = "subnet-a98895e4" # eu-central-1c
}

variable "instance_type" {
  default = "TYPE"
}

variable "max_size" {
  default = "MAX_SIZE"
}

variable "min_size" {
  default = "MIN_SIZE"
}

variable "key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjx9DbCq+x5Vu95aTP1jmL7dknDj+AHeCGseh2d8aVk96uYoeK3hjTAUPzFAlPOaDto8QGELblb8kueDUvTZOZwVFRVD3saxf8sqh8u0SDeA4fRlrETzNlfjDYM/zqDvoUjyw4QLS1Gge2mLJgoufvqRVYAA6qb3NSwkIk5n3RCtVHe5zpJPAq55ybgIyFeJR8dG1lDv/30OJi8bkP5HxXNvU9Z15KmVJmSJUM7JZGzGrOgiDN4g05qbWx0EuXb+VaEGzDUq+GIjKMPu0NLpoza25LqFYKDLgmTkr/7ze9tsSJhuOhgpccg7pBUDy0E+2PiUWXsrfkMM5IFJ4I6MPT eposadas"
}

variable "user_data" {
  default = <<EOF
#!/bin/bash
apt-get update
sudo apt-get -y install python-dev build-essential
sudo apt-get -y install python-pip
sudo pip install --upgrade pip
sudo pip install Flask==0.12.0
sudo pip install gunicorn
EOF
}
