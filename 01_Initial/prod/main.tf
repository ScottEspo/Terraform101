## Create an EC2 instance manually
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "web_server" {
  #ami           = "ami-0e9424b478c1c61c5" 
  ami                  = data.aws_ami.amazon.id
  instance_type        = "t2.small" ## Note the much beefier instance size for PROD :)
  security_groups      = [aws_security_group.web_server_sg.name]
  iam_instance_profile = aws_iam_instance_profile.tf_demo_instance_profile.name
  user_data            = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd.x86_64
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
systemctl start httpd.service
systemctl enable httpd.service
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
export tfservername='curl http://169.254.169.254/latest/meta-data/hostname'
export instancetype='curl http://169.254.169.254/latest/meta-data/instance-type'
echo "<h1>WooHoo... Terraform! (deployed to prod) running on a $($instancetype) named $($tfservername) </h1>" > /var/www/html/index.html
EOF
  tags = {
    Name         = "tf-demo-web-server-Prod" ## Another Manual Change for a different deployment environment
    Environment  = "dev"
    Project      = "Daugherty Terraform Demo"
    OrgCode      = "1026"
    DeployedFrom = "tf 101 repository"
  }
}

## Creating an Application Load Balancer
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

resource "aws_lb" "tf-demo-lb" {
  name                       = "terraform-demo-lb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  subnets                    = ["subnet-YOURS1", "subnet-YOURS2", "subnet-YOURS3"] ## Another Manual Change for a different deployment environment
  security_groups            = [aws_security_group.lb_sg.id]
  tags = {
    Name         = "tf-demo-lb"
    Environment  = "something else"
    Project      = "Daugherty"
    OrgCode      = "1026"
    DeployedFrom = "tf 101 repository"
  }
}

## Creating a Target Group 
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "tf_demo_tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-YOURS1" ## Another Manual Change for a different deployment environment
  health_check {
    port     = "80"
    path     = "/"
    protocol = "HTTP"
  }
}

## Create a listener on the load balancer and forward traffic to target group created above
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.tf-demo-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_demo_tg.arn
  }
}

## Attach instance created above to the Target Group so that traffic will be forwarded to it
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
resource "aws_lb_target_group_attachment" "tf_demo_tg_attachment" {
  target_group_arn = aws_lb_target_group.tf_demo_tg.arn
  target_id        = aws_instance.web_server.id
  port             = 80
}

## DNS - Let's create a Friendly DNS name and point it to the Load Balancer
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "tf-demo" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "tf-demo-prod.YOUR_DOMAIN_NAME.com" ## Another Manual Change for a different deployment environment
  type    = "A"

  alias {
    name                   = aws_lb.tf-demo-lb.dns_name
    zone_id                = aws_lb.tf-demo-lb.zone_id
    evaluate_target_health = true
  }
}


## Not deploying this since we still have the resource created from the dev apply

# resource "aws_route53_record" "tf-demo_provider_example" {
#   provider = aws.aws_prod                         ## Telling Terraform to use the provider with alias aws_prod so we can use the aws profile in credentials for PROD
#   zone_id  = data.aws_route53_zone.parent_zone.id ## Referencing the Zone we collected info from in data.tf
#   name     = "provider-example.YOUR_DOMAIN_NAME.com"
#   type     = "A"

#   alias {
#     name                   = aws_lb.tf-demo-lb.dns_name ## Referencing the LB we created above
#     zone_id                = aws_lb.tf-demo-lb.zone_id  ## Referencing the LB we created above
#     evaluate_target_health = true
#   }
# }