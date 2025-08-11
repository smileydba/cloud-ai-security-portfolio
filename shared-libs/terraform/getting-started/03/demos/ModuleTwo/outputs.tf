output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "All public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "security_group_id" {
  description = "Web security group ID"
  value       = module.security.security_group_id
}

output "nginx_instance_id" {
  description = "EC2 instance ID"
  value       = module.web_server.instance_id
}

output "nginx_public_dns" {
  description = "Public DNS for NGINX"
  value       = module.web_server.public_dns
}
