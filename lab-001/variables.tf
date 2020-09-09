variable "region" {
  description = "Workspace region"
  default     = "us-west-2" # US West (Oregon)
}

variable "prefix" {
  description = "Add this prefix to the resources name to make it easier to distinguish"
  default     = "lab-001"
}