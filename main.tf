# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  profile = var.profile
  region  = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS Cluster
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_cluster" "nexus_cluster" {
  name = "${var.name_preffix}-nexus"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS KMS Encryption Key
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_kms_key" "encryption_key" {
  description         = "Nexus Encryption Key"
  is_enabled          = true
  enable_key_rotation = true
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS Fargate Service
# ---------------------------------------------------------------------------------------------------------------------
module "ecs_fargate" {
  source  = "jnonino/ecs-fargate/aws"
  version = "2.0.1"
  #source = "../terraform-aws-ecs-fargate"

  name_preffix                 = "${var.name_preffix}-nexus"
  profile                      = var.profile
  region                       = var.region
  vpc_id                       = var.vpc_id
  availability_zones           = ["var.availability_zones"]
  public_subnets_ids           = ["var.public_subnets_ids"]
  private_subnets_ids          = ["var.private_subnets_ids"]
  container_name               = "${var.name_preffix}-nexus"
  container_image              = "sonatype/nexus3:3.17.0"
  container_cpu                = 1024
  container_memory             = 8192
  container_memory_reservation = 2048
  container_port               = 8081
}
