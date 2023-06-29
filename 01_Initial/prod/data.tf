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
data "aws_route53_zone" "selected" {
  name         = "YOUR_HOSTED_ZONE_INFO_HERE."
  private_zone = false
}