resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_dns}"
  acl    = "private"

  tags = {
    Name = "${var.bucket_name}"
  }
}

locals {
  s3_origin_id = "myS3Origin"
}