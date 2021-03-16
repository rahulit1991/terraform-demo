# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "ELB_endpoint" {
  description = "Load Balancer Endpoint"
  value       = module.elb.this_elb_dns_name
}

output "Instance_EIP" {
  description = "Bastion server Elastic IP"
  value = aws_eip.server_eip.public_ip
}








