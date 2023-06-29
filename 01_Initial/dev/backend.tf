terraform {
  backend "local" {
  }
}

##  This can be remote as well (S3, GCS, Consul...) (you should do remote :) )

# terraform {
#   backend "s3" {
#     bucket = "BUCKET NAME HERE"
#     key    = "tf-demo/terraform.tfstate"
#     region = "us-east-1"
#   }
# }