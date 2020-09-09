# terraform
IaC using Terraform

First start:
1. draft main.tf

Content example:
```
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
```
2. run `$ terraform init`
3. create `.gitignore` with content:
```
.terraform
terraform.tfstate
terraform.tfstate.backup
```
4. Define credentials

    4.1 AWS
    - [How to create access_key](https://aws.amazon.com/blogs/security/wheres-my-secret-access-key/)