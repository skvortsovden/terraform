# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = "" # user access key here
  secret_key = "" # user secret key here
  # or
  # $ export AWS_ACCESS_KEY_ID="anaccesskey"
  # $ export AWS_SECRET_ACCESS_KEY="asecretkey"
}

terraform {
  required_version = "0.12.21"

# BEST-PRACTICE: create S3 bucket for storing terraform state file
# backend "s3" {
#   bucket = "terraform-state"
#   key = "terrafrom.tfstate"
#   region = var.region
# }
}

# 1. Create **VPC** 
# 2. Create **1 private** and **1 public** subnet
# 3. Deploy **1 EC2** instance to **public subnet**
# 4. Deploy SSH public key and associate it with EC2 instance
# 5. Create **IGW**
# 6. Attach **IGW** to **VPC**
# 7. Create **Private RT** and associate it with **private subnet**
# 8. Create **Public RT** and associate it with **public subnet**
# 9. Add **Route** for **Public RT** *(dest: 0.0.0.0/0, targer: IGW)*
# 10. Create Security Group to allow SSH traffic
# 11. Connect to EC2 instance using SSH with private key