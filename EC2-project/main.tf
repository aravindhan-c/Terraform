provider "aws" {
    region = "us-east-1"  
}

module "ec2-creation" {
    source = "./modules/ec2"
    ami-value = "ami-0f88e80871fd81e91"
    instance-type-value = "t2.micro"  
}

module "s3-bucket" {
  source = "./modules/s3"
  bucket-name = "terraform-state-bucket-20250405"
  providers = {
    aws = aws
  }
}

module "dynamodb-lock-table" {
  source = "./modules/dynamodb"
  dynamodb-lock-table = "terrform-lock"
  providers = {
    aws = aws
  }
}