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
  version = "1.0.12"
  # source  = "../terraform-aws-cloudwatch-logs"

  create_kms_key              = var.create_kms_key
  log_group_kms_key_id        = var.log_group_kms_key_id
  log_group_retention_in_days = var.log_group_retention_in_days
  logs_path                   = "/ecs/service/${var.name_prefix}-nexus"
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
  version = "2.0.48"
  # source = "../terraform-aws-ecs-fargate"

  name_prefix                  = "${var.name_prefix}-nexus"
  vpc_id                       = var.vpc_id
  public_subnets_ids           = var.public_subnets_ids
  private_subnets_ids          = var.private_subnets_ids
  container_name               = "${var.name_prefix}-nexus"
  container_image              = var.nexus_image
  container_cpu                = var.container_cpu
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation

  # Container ephemeral storage on Fargate tasks
  ephemeral_storage_size = var.ephemeral_storage_size
  volumes                = var.volumes
  mount_points           = var.mount_points

  # Application Load Balancer
  custom_lb_arn                       = var.custom_lb_arn
  lb_http_ports                       = var.lb_http_ports
  lb_https_ports                      = var.lb_https_ports
  lb_enable_cross_zone_load_balancing = var.lb_enable_cross_zone_load_balancing
  lb_waf_web_acl_arn                  = var.lb_waf_web_acl_arn
  default_certificate_arn             = var.configure_loadbalancer_ssl.enable_ssl ? module.acm[0].acm_certificate_arn : null

  # Application Load Balancer Logs
  enable_s3_logs                                 = var.enable_s3_logs
  block_s3_bucket_public_access                  = var.block_s3_bucket_public_access
  enable_s3_bucket_server_side_encryption        = var.enable_s3_bucket_server_side_encryption
  s3_bucket_server_side_encryption_sse_algorithm = var.s3_bucket_server_side_encryption_sse_algorithm
  s3_bucket_server_side_encryption_key           = var.s3_bucket_server_side_encryption_key

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

  tags = var.tags
}

#------------------------------------------------------------------------------
# ACM - Load Balancer Certificate
#------------------------------------------------------------------------------

resource "aws_route53_record" "record_dns" {
  count = var.configure_loadbalancer_ssl.enable_ssl ? 1 : 0

  zone_id = var.configure_loadbalancer_ssl.dns_zone_id
  name    = var.configure_loadbalancer_ssl.https_record_name
  type    = "A"

  alias {
    name                   = module.ecs_fargate.aws_lb_lb_dns_name
    zone_id                = module.ecs_fargate.aws_lb_lb_zone_id
    evaluate_target_health = true
  }
}

module "acm" {
  count = var.configure_loadbalancer_ssl.enable_ssl ? 1 : 0

  source  = "terraform-aws-modules/acm/aws"
  version = "4.1.1"

  domain_name = var.configure_loadbalancer_ssl.https_record_domain_name
  zone_id     = var.configure_loadbalancer_ssl.dns_zone_id

  subject_alternative_names = [
    "*.${var.configure_loadbalancer_ssl.https_record_domain_name}",
  ]

  wait_for_validation = true

  tags = var.tags
}
