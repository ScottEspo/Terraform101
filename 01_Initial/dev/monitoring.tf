# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor

## Comment this out if you are not adding the DataDog Monitor (or just delete the file - doesn't really matter)
resource "datadog_monitor" "tf_demo_monitor" {
  name    = "Terraform Demo Monitor"
  type    = "metric alert"
  message = "Monitor triggered. Notify: @YOUR_DD_USER_NAME_HERE"

  query = "avg(last_1m):avg:aws.ec2.cpuutilization.maximum{host:${aws_instance.web_server.id}} by {instance_id} > 60"

  include_tags = true

}