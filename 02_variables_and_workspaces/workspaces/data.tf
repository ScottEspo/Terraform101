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

data "aws_route53_zone" "selected" {
  name         = var.hosted_zone
  private_zone = false
}

data "aws_vpc" "vpc" {
  default = true
}

data "aws_subnets" "internal_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_route53_zone" "parent_zone" {
  count        = var.environment == "dev" ? 1 : 0
  provider     = aws.aws_prod
  name         = "${var.alternate_hosted_zone}."
  private_zone = false
}