# Sonatype Nexus Terraform Module for AWS #

This Terraform module deploys a Sonatype Nexus OOS on AWS. Based on official Sonatype Nexus Docker image <https://hub.docker.com/r/sonatype/nexus/>.

[![CircleCI](https://circleci.com/gh/jnonino/terraform-aws-nexus/tree/master.svg?style=svg)](https://circleci.com/gh/jnonino/terraform-aws-nexus/tree/master)

## Usage
 
    module "nexus" {
        source              = "jnonino/nexus/aws"
        name_preffix        = "${var.name_preffix}"
        profile             = "${var.profile}"
        region              = "${var.region}"
        vpc_id              = "${module.networking.vpc_id}"
        availability_zones  = [ "${var.availability_zones}" ]
        public_subnets_ids  = [ "${module.networking.public_subnets_ids}" ]
        private_subnets_ids = [ "${module.networking.private_subnets_ids}" ]
    }

## Output values

* nexus_alb_id: Sonatype Nexus Application Load Balancer ID.
* nexus_alb_arn: Sonatype Nexus Application Load Balancer ARN.
* nexus_alb_arn_suffix: Sonatype Nexus Application Load Balancer ARN Suffix.
* nexus_alb_dns_name: Sonatype Nexus Application Load Balancer DNS Name.
* nexus_alb_zone_id: Sonatype Nexus Application Load Balancer Zone ID.
