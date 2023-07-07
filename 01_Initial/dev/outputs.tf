## If you are not using a custom domain you can comment these two out
output "web_page" {
  description = "Web URL of LB"
  value       = "http://${aws_route53_record.tf-demo.name}/"
}

output "fancy_web_page" {
  description = "Web URL of LB"
  value       = "http://${aws_route53_record.tf-demo_provider_example.name}/"
}

output "load_balancer_url" {
  description = "URL of Load Balancer"
  value       = aws_lb.tf-demo-lb.dns_name
}

output "web_server_instance_id" {
  description = "instance id of we server created"
  value       = aws_instance.web_server.id
}