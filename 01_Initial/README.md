# Terraform 101

## 01_Initial - not scalable or re-usable :sob:

Everything in here is declared manually - nothing reused, little to no references

Unless you are at an organization where EVERYTHING must be declared using a private model regisrty (I was there)... the Terriform Registry will be your best friend.  the main link with all of the providers is here: [Terraform Provider Registry](https://registry.terraform.io/browse/providers).

Here, we will be focusing mostly on AWS, so - [AWS Provider Registry Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) (This bookmark even gets its own place on my Bookmark Bar in Chrome!)

You will notice above each resource there is a link to the Provider Documentation in the terriform registry for that resource 

For any provider you'll want to use you'll need to put that in your providers.tf file like so:

```
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
```
and then any specific configs for them like this:
```
provider "aws" {
  region  = "us-east-1"
  profile = "terraform-dev"
}


provider "datadog" {
  api_key = "1_SECRET_API_KEY_FROM_DD_2"
  app_key = "SECRET_APP_KEY_FROM_DD"

}
```

The code is pretty much all of the declared resources using the registry as a guide with examples and a list of arguments and attributes for each available resource. 

STEPS:
1. terraform fmt
2. terraform init
3. terraform plan
4. terraform apply
5. terraform destroy

Note: I put most comments in the Dev code - but most of the same aapplies to Prod