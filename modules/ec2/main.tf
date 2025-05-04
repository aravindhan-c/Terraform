provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "mywebserver" {
  ami = var.ami-value
  instance_type = var.instance-type-value
}