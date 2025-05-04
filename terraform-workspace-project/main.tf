provider "aws" {
  region = "us-east-1"
}

variable "ami-value" {
  description = "ami for ec2"
}

variable "instance-type-value" {
  description = "instance type for ec2"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.large"
  }
}

module "ec2-module" {
  source = "./modules/ec2"
  ami-value = var.ami-value
  instance-type-value = lookup(var.instance-type-value, terraform.workspace, "t2.micro")

}