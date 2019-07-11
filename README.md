# Sonatype Nexus Terraform Module for AWS #

This Terraform module deploys a Sonatype Nexus OOS on AWS. Based on official Sonatype Nexus Docker image <https://hub.docker.com/r/sonatype/nexus/>.

[![CircleCI](https://circleci.com/gh/jnonino/terraform-aws-nexus/tree/master.svg?style=svg)](https://circleci.com/gh/jnonino/terraform-aws-nexus/tree/master)

## Usage
 
        module "nexus" {
            source              = "jnonino/nexus/aws"
            name_preffix        = var.name_preffix
            profile             = var.profile
            region              = var.region
            vpc_id              = module.networking.vpc_id
            availability_zones  = module.networking.availability_zones
            public_subnets_ids  = module.networking.public_subnets_ids
            private_subnets_ids = module.networking.private_subnets_ids
        }

The networking module should look like this:

        module "networking" {
    	    source          = "jnonino/networking/aws"
            version         = "2.0.3"
            name_preffix    = "base"
            profile         = "aws_profile"
            region          = "us-east-1"
            vpc_cidr_block  = "192.168.0.0/16"
            availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
            public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
            private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
    	}

Check versions for this module on:
* Github Releases: <https://github.com/jnonino/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/networking/aws>

## Output values

* nexus_alb_id: Sonatype Nexus Application Load Balancer ID.
* nexus_alb_arn: Sonatype Nexus Application Load Balancer ARN.
* nexus_alb_arn_suffix: Sonatype Nexus Application Load Balancer ARN Suffix.
* nexus_alb_dns_name: Sonatype Nexus Application Load Balancer DNS Name.
* nexus_alb_zone_id: Sonatype Nexus Application Load Balancer Zone ID.
