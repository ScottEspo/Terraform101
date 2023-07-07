variable "profile" {
  description = "aws profile to use"
}

variable "prod_profile" {
  description = "aws profile to use for PROD account"
}

variable "hosted_zone" {
  description = "Hosted Zone where you want to your new site to live"
  type        = string
}

variable "alternate_hosted_zone" {
  description = "Hosted Zone where you want to your new site to live"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "instance type for your ec2 instance"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "environment name"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "The environment must be \"dev\", \"test\", or \"prod\"."
  }
}

variable "project" {
  description = "project name"
  type        = string
}
variable "orgCode" {
  description = "Org code for billing"
  type        = string
  default     = "1026"
}

variable "enable_monitoring" {
  description = "set this to true if you would like to enable DataDog Monitoring"
  type        = bool
  default     = false
}
