terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-20250405"
    region = "us-east-1"
    key = "terraform/statefiles/terraform.tfstate"
    dynamodb_table = "terrform-lock"
  }
}