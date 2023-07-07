## Let's remove everything specific to this AWS Account/Environment

resource "aws_instance" "web_server" {
  count                = var.environment != "prod" ? 1 : 2 ### Adding some logic to create multiple instances if PROD (many ways to achieve similar results)
  ami                  = data.aws_ami.amazon.id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.web_server_sg.name]
  iam_instance_profile = aws_iam_instance_profile.tf_demo_instance_profile.name
  user_data            = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd.x86_64
sudo amazon-linux-extras install epel -y
systemctl start httpd.service
systemctl enable httpd.service
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
export tfservername='curl http://169.254.169.254/latest/meta-data/hostname'
export instancetype='curl http://169.254.169.254/latest/meta-data/instance-type'
echo "<h1>WooHoo... Terraform! (deployed to ${var.environment}) running on a $($instancetype) named $($tfservername) </h1>" > /var/www/html/index.html
EOF
  tags = {
    Name         = "${local.instance_name}-instance-${(count.index) + 1}" ## Using some logic to give this a unique name
    Environment  = var.environment
    Project      = var.project
    OrgCode      = var.orgCode
    DeployedFrom = "${path.cwd}-${terraform.workspace}" ## Good to have if wondering where the resource was declared from :)
  }
}

resource "aws_lb" "tf-demo-lb" {
  name                       = local.load_balancer_name
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  subnets                    = local.subnets
  security_groups            = [aws_security_group.lb_sg.id]
  tags = {
    Name         = local.load_balancer_name
    Environment  = var.environment
    Project      = var.project
    OrgCode      = var.orgCode
    DeployedFrom = "${path.cwd}-${terraform.workspace}"
  }
}

resource "aws_lb_target_group" "tf_demo_tg" {
  name     = local.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id ## Replaced VPC ID with data call value
  health_check {
    port     = "80"
    path     = "/"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.tf-demo-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_demo_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tf_demo_tg_attachment" {
  count            = length(aws_instance.web_server) ## The number of attachments depends on the number of instances we created
  target_group_arn = aws_lb_target_group.tf_demo_tg.arn
  target_id        = aws_instance.web_server[count.index].id
  port             = 80
}

resource "aws_route53_record" "tf-demo" {
  zone_id = data.aws_route53_zone.selected.id
  name    = local.dns_name ## got fancy by constructing the name from variables
  type    = "A"

  alias {
    name                   = aws_lb.tf-demo-lb.dns_name
    zone_id                = aws_lb.tf-demo-lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "tf-demo_provider_example" {
  count    = terraform.workspace == "dev" ? 1 : 0 ## Similar to above but using the workspace selection this time
  provider = aws.aws_prod
  zone_id  = data.aws_route53_zone.parent_zone[0].id
  name     = "provider-example.${var.alternate_hosted_zone}"
  type     = "A"

  alias {
    name                   = aws_lb.tf-demo-lb.dns_name
    zone_id                = aws_lb.tf-demo-lb.zone_id
    evaluate_target_health = true
  }


}