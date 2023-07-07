locals {
  trimmed_project    = replace(var.project, "/\\s+/", "")
  instance_name      = "${var.project}-${var.environment}"
  load_balancer_name = "${local.trimmed_project}-LB"
  subnets            = toset(data.aws_subnets.internal_subnets.ids)
  target_group_name  = "${local.trimmed_project}-tg"
  dns_name           = "tf-demo-${var.environment}.${var.hosted_zone}"
}