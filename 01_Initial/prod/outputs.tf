output "web_page" {
  description = "Web URL of LB"
  value       = "http://${aws_route53_record.tf-demo.name}/"
}

output "web_server_instance_id" {
  description = "instance id of we server created"
  value       = aws_instance.web_server.id
}