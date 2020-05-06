#------------------------------------------------------------------------------
# Sonatype Nexus ALB DNS
#------------------------------------------------------------------------------
output "nexus_lb_id" {
  description = "Sonatype Nexus Load Balancer ID"
  value       = module.ecs_fargate.aws_lb_lb_id
}

output "nexus_lb_arn" {
  description = "Sonatype Nexus Load Balancer ARN"
  value       = module.ecs_fargate.aws_lb_lb_arn
}

output "nexus_lb_arn_suffix" {
  description = "Sonatype Nexus Load Balancer ARN Suffix"
  value       = module.ecs_fargate.aws_lb_lb_arn_suffix
}

output "nexus_lb_dns_name" {
  description = "Sonatype Nexus Load Balancer DNS Name"
  value       = module.ecs_fargate.aws_lb_lb_dns_name
}

output "nexus_lb_zone_id" {
  description = "Sonatype Nexus Load Balancer Zone ID"
  value       = module.ecs_fargate.aws_lb_lb_zone_id
}
