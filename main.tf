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
module "aws_cw_logs" {
  source  = "cn-terraform/cloudwatch-logs/aws"
  version = "1.0.10"
  # source  = "../terraform-aws-cloudwatch-logs"

  logs_path = "/ecs/service/${var.name_prefix}-nexus"
}

#------------------------------------------------------------------------------
# EFS
#------------------------------------------------------------------------------
# resource "aws_efs_file_system" "nexus_data" {
#   creation_token = "${var.name_prefix}-nexus-efs"
#   tags = {
#     Name = "${var.name_prefix}-nexus-efs"
#   }
# }
# resource "aws_security_group" "nexus_data_allow_nfs_access" {
#   name        = "${var.name_prefix}-nexus-efs-allow-nfs"
#   description = "Allow NFS inbound traffic to EFS"
#   vpc_id      = var.vpc_id
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "${var.name_prefix}-nexus-efs-allow-nfs"
#   }
# }

# data "aws_subnet" "private_subnets" {
#   count = length(var.private_subnets_ids)
#   id    = element(var.private_subnets_ids, count.index)
# }

# resource "aws_security_group_rule" "nexus_data_allow_nfs_access_rule" {
#   security_group_id        = aws_security_group.nexus_data_allow_nfs_access.id
#   type                     = "ingress"
#   from_port                = 2049
#   to_port                  = 2049
#   protocol                 = "tcp"
#   source_security_group_id = module.ecs-fargate-service.ecs_tasks_sg_id
# }

# resource "aws_efs_mount_target" "nexus_data_mount_targets" {
#   count           = length(var.private_subnets_ids)
#   file_system_id  = aws_efs_file_system.nexus_data.id
#   subnet_id       = element(var.private_subnets_ids, count.index)
#   security_groups = [aws_security_group.nexus_data_allow_nfs_access.id]
# }

#------------------------------------------------------------------------------
# ECS Fargate Service
#------------------------------------------------------------------------------
module "ecs_fargate" {
  source  = "cn-terraform/ecs-fargate/aws"
  version = "2.0.33"
  # source = "../terraform-aws-ecs-fargate"

  name_prefix                  = "${var.name_prefix}-nexus"
  vpc_id                       = var.vpc_id
  public_subnets_ids           = var.public_subnets_ids
  private_subnets_ids          = var.private_subnets_ids
  container_name               = "${var.name_prefix}-nexus"
  container_image              = var.nexus_image
  container_cpu                = 4096
  container_memory             = 8192
  container_memory_reservation = 4096
  lb_http_ports = {
    default = {
      listener_port     = 80
      target_group_port = 8081
    }
  }
  lb_https_ports = {}
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
  ulimits = [
    {
      name      = "nofile"
      hardLimit = 65536
      softLimit = 65536
    }
  ]
}
