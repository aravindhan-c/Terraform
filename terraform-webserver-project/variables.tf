variable "region" {
  description = "region where my infrastrcture reside"
  type        = string
  default     = "us-east-1"
}

variable "vpc-cidr" {
  description = "cidr block details for the app vpc"
  default     = "10.0.0.0/16"
}

variable "subnet1-cidr" {
  description = "cidr block details for the subnet1"
  default     = "10.0.0.0/24"
}

variable "subnet2-cidr" {
  description = "cidr block details for the subnet2"
  default     = "10.0.1.0/24"
}

variable "ami" {
  default = "ami-0f88e80871fd81e91"
}

variable "instance-type" {
  default = "t2.micro"
}