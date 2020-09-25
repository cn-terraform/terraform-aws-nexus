#------------------------------------------------------------------------------
# AWS KMS Encryption Key
#------------------------------------------------------------------------------
# resource "aws_kms_key" "encryption_key" {
#   description         = "Nexus Encryption Key"
#   is_enabled          = true
#   enable_key_rotation = true
# }

#------------------------------------------------------------------------------
# AWS Cloudwatch Logs
#------------------------------------------------------------------------------
module aws_cw_logs {
  source  = "cn-terraform/cloudwatch-logs/aws"
  version = "1.0.7"
  # source  = "../terraform-aws-cloudwatch-logs"

  logs_path = "/ecs/service/${var.name_prefix}-nexus"
}

#------------------------------------------------------------------------------
# ECS Fargate Service
#------------------------------------------------------------------------------
module "ecs_fargate" {
  source  = "cn-terraform/ecs-fargate/aws"
  version = "2.0.20"
  # source = "../terraform-aws-ecs-fargate"

  name_prefix                  = "${var.name_prefix}-nexus"
  vpc_id                       = var.vpc_id
  public_subnets_ids           = var.public_subnets_ids
  private_subnets_ids          = var.private_subnets_ids
  container_name               = "${var.name_prefix}-nexus"
  container_image              = "sonatype/nexus3"
  container_cpu                = 4096
  container_memory             = 8192
  container_memory_reservation = 4096
  lb_http_ports                = [8081]
  lb_https_ports               = []
  port_mappings = [
    {
      containerPort = 8081
      hostPort      = 8081
      protocol      = "tcp"
    }
  ]
  environment = [
    {
      name  = "NEXUS_SECURITY_RANDOMPASSWORD"
      value = "false"
    },
  ]
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-region"        = var.region
      "awslogs-group"         = "/ecs/service/${var.name_prefix}-nexus"
      "awslogs-stream-prefix" = "ecs"
    }
    secretOptions = null
  }
}
