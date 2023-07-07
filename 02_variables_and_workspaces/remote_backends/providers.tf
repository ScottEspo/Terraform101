#https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " >= 4.57.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "3.26.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

provider "aws" {
  region  = "us-east-1"
  profile = var.prod_profile
  alias   = "aws_prod"
}

provider "aws" {
  region  = "us-east-1"
  profile = var.dev_profile
  alias   = "aws_dev"
}

provider "datadog" {
  api_key = "YOUR_DD_API_KEY_HERE"
  app_key = "YOUR_DD_APP_KEY_HERE"
}