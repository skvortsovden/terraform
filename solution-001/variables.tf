variable "region" {
  description = "Workspace region"
  default     = "us-west-2" # US West (Oregon)
}

variable "zones" {
  description = "Multi zone deployment"
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}