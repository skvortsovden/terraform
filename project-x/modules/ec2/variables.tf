variable "instance_name" {
  description = "Default name for ec2 instance"
  default     = "ec2-instance"
}
variable "instance_type" {
  description = "Default type of ec2 instance"
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  description   = "Assign public IP to ec2 instance"
  default       = false
}

variable "subnet_id" {
    description = "Default subnet id for ec2 inctance"
    default     = ""
}

variable "pub_key_name" {
  description   = "Name of pub key for ssh connection to ec2 inctance"
  default       = ""
}
