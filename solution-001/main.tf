# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = "" # user access key here
  secret_key = "" # user secret key here
}

terraform {
  required_version = "0.12.21"

# BEST-PRACTICE: create S3 bucket for storing terraform state file
# backend "s3" {
#   bucket = "terraform-state"
#   key = "terrafrom.tfstate"
#   region = "${var.region}"
# }
}


