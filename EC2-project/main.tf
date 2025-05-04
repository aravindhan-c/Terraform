provider "aws" {
    region = "us-east-1"
  
}

module "ec2-creation" {
    source = "./modules/ec2"
    ami-value = "ami-0f88e80871fd81e91"
    instance-type-value = "t2.micro"  
}