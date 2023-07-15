module "default_tags" {
  source = "git::https://github.com/ScottEspo/terraform-modules.git//common_tags/"
  environment = var.environment
  orgCode     = var.orgCode
  project     = var.project
}

module "web_server_with_alb" {
  source = "git::https://github.com/ScottEspo/terraform-modules.git//ec2_web"


  hosted_zone           = var.hosted_zone
  alternate_hosted_zone = var.alternate_hosted_zone
  project               = var.project
  environment           = var.environment
  datadog_api_key       = var.datadog_api_key
  datadog_app_key       = var.datadog_app_key
  profile               = var.profile
  prod_profile          = var.prod_profile
  tags                  = module.default_tags.tags
  enable_monitoring     = var.enable_monitoring
}