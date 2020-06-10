provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "main_secgroup" {
  name        = "${var.prefix}-sg"
  description = "security group for the app"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${var.vpc}"
}

resource "aws_key_pair" "main" {
  key_name   = "${var.prefix}-key"
  public_key = "${var.key}"
}

resource "aws_launch_configuration" "main_lc" {
  name                        = "${var.prefix}-lc"
  image_id                    = "ami-30e01d5f"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${aws_security_group.main_secgroup.id}"]
  user_data                   = "${var.user_data}"
  key_name                    = "${aws_key_pair.main.key_name}"
  associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "main_asg" {
  availability_zones   = ["eu-central-1a", "eu-central-1b"]
  name                 = "${var.prefix}-asg"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.main_lc.name}"
  tags = [
    {
      key                 = "Name"
      value               = "${var.prefix}-instance"
      propagate_at_launch = true
    }
  ]
}
