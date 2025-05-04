provider "aws" {
  region = "us-east-1"
}

variable "ami-value" {
  description = "ami id for ec2 instance"
}

variable "instance-type-value" {
  description = "instance type for ec2"
}

resource "aws_instance" "webserver" {
  ami = var.ami-value
  instance_type = var.instance-type-value
}