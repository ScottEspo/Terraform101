#https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " >= 4.57.0"
    }
    ## Comment this block out if you are not going to add the DataDog Monitor
    datadog = {
      source  = "DataDog/datadog"
      version = "3.26.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform-dev"  ## name of your profile in .aws/credentials
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform-prod"  ## name of your profile in .aws/credentials
  alias   = "aws_prod"
}

    ## Comment this block out if you are not going to add the DataDog Monitor
provider "datadog" {
  api_key = "YOUR_DD_API_KEY_HERE"
  app_key = "YOUR_DD_APP_KEY_HERE"

}