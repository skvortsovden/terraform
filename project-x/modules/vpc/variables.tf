variable "name" {
  description = "VPC resource name"
  default     = "virtual-private-cloud"
}

variable "cidr" {
  description = "CIDR for VPC network"
  default     = "10.0.0.0/16"
}

