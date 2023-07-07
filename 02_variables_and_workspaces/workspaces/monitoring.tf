# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor

resource "datadog_monitor" "tf_demo_monitor" {
  count   = var.enable_monitoring == true ? length(aws_instance.web_server) : 0 ## We only care to monitor if we set that variable to TRUE
  name    = "Terraform Demo Monitor PROD"
  type    = "metric alert"
  message = "Monitor triggered. Notify: @YOUR_DD_USER_NAME_HERE"

  query = "avg(last_1m):avg:aws.ec2.cpuutilization.maximum{host:${aws_instance.web_server[count.index].id}} by {instance_id} > 60"

  include_tags = true

}