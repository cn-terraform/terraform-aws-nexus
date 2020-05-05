# Sonatype Nexus Terraform Module for AWS #

This Terraform module deploys a Sonatype Nexus OOS on AWS. Based on official Sonatype Nexus Docker image <https://hub.docker.com/r/sonatype/nexus/>.

[![CircleCI](https://circleci.com/gh/cn-terraform/terraform-aws-nexus/tree/master.svg?style=svg)](https://circleci.com/gh/cn-terraform/terraform-aws-nexus/tree/master)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)

## Usage

        module "nexus" {
            source              = "cn-terraform/nexus/aws"
            name_preffix        = var.name_preffix
            profile             = var.profile
            region              = var.region
            vpc_id              = module.networking.vpc_id
            availability_zones  = module.networking.availability_zones
            public_subnets_ids  = module.networking.public_subnets_ids
            private_subnets_ids = module.networking.private_subnets_ids
        }

## Other modules that you may need to use this module

The Networking module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

## Output values

* nexus_alb_id: Sonatype Nexus Application Load Balancer ID.
* nexus_alb_arn: Sonatype Nexus Application Load Balancer ARN.
* nexus_alb_arn_suffix: Sonatype Nexus Application Load Balancer ARN Suffix.
* nexus_alb_dns_name: Sonatype Nexus Application Load Balancer DNS Name.
* nexus_alb_zone_id: Sonatype Nexus Application Load Balancer Zone ID.
