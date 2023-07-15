terraform {
  backend "s3" {
    bucket  = "YOUR_BUCKET_NAME_HERE"
    key     = "tf-demo/terraform.tfstate" ## you can change this to any prefix you want
    region  = "us-east-1"
    profile = "YOUR_AWS_CLI_PROFILE_HERE"
  }
}