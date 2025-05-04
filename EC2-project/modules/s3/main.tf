terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



resource "aws_s3_bucket" "s3-bucket" {
    bucket = var.bucket-name  
}