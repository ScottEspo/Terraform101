## Lookup an AMI to use in AWS
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

## Lookup Hosted Zone
# Comment this out if you are not using a custom domain name
data "aws_route53_zone" "selected" {
  name         = "YOUR_HOSTED_ZONE_INFO_HERE"
  private_zone = false
}


## Let's Get the hosted Zone info from the PROD AWS Account so we can create a resource in an alternate account
# Comment this out if you are not using a custom domain name
data "aws_route53_zone" "parent_zone" {
  provider     = aws.aws_prod ## Note we are using an alternate provider (aka different credentials)
  name         = "YOUR_HOSTED_ZONE_INFO_HERE"
  private_zone = false
}