#https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " >= 4.57.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform-prod"
}