variable "subnet_name" {
  description   = "Default name for subnet"
  default       = "subnet"
}

variable "vpc_id" {
  description   = "Default VPC Id for subnet"
  default       = ""
}

variable "cidr_block" {
    description = "Default CIDR for subnet"
    default     = "10.10.0.0/16"
}