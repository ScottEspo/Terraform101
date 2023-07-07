output "web_page" {
  description = "Web URL of LB"
  value       = "http://${aws_route53_record.tf-demo.name}/"
}

output "web_server_instance_id" {
  description = "instance id of we server created"
  value       = aws_instance.web_server[*].id
}

output "prod_dns_example" {
  description = "this is the dns created in prod, but we only want to see it if it was being created"
  value       = var.environment == "dev" ? "http://${aws_route53_record.tf-demo_provider_example[0].name}/" : "Not Created!"
}