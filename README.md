# Sonatype Nexus Terraform Module for AWS #

This Terraform module deploys a Sonatype Nexus OOS on AWS. Based on official Sonatype Nexus Docker image <https://hub.docker.com/r/sonatype/nexus/>.

[![](https://github.com/cn-terraform/terraform-aws-nexus/workflows/terraform/badge.svg)](https://github.com/cn-terraform/terraform-aws-nexus/actions?query=workflow%3Aterraform)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-nexus)](https://github.com/cn-terraform/terraform-aws-nexus)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-nexus/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/nexus/aws>

## Other modules that you may need to use this module

The Networking module:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

## Install pre commit hooks.

Pleas run this command right after cloning the repository.

        pre-commit install

For that you may need to install the folowwing tools:
* [Pre-commit](https://pre-commit.com/)
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

        pre-commit run --all-files

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_cw_logs"></a> [aws\_cw\_logs](#module\_aws\_cw\_logs) | cn-terraform/cloudwatch-logs/aws | 1.0.10 |
| <a name="module_ecs_fargate"></a> [ecs\_fargate](#module\_ecs\_fargate) | cn-terraform/ecs-fargate/aws | 2.0.39 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of Availability Zones | `list(any)` | n/a | yes |
| <a name="input_block_s3_bucket_public_access"></a> [block\_s3\_bucket\_public\_access](#input\_block\_s3\_bucket\_public\_access) | (Optional) If true, public access to the S3 bucket will be blocked. | `bool` | `true` | no |
| <a name="input_enable_s3_bucket_server_side_encryption"></a> [enable\_s3\_bucket\_server\_side\_encryption](#input\_enable\_s3\_bucket\_server\_side\_encryption) | (Optional) If true, server side encryption will be applied. | `bool` | `true` | no |
| <a name="input_enable_s3_logs"></a> [enable\_s3\_logs](#input\_enable\_s3\_logs) | (Optional) If true, all resources to send LB logs to S3 will be created | `bool` | `true` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for resources on AWS | `any` | n/a | yes |
| <a name="input_nexus_image"></a> [nexus\_image](#input\_nexus\_image) | Nexus image | `string` | `"sonatype/nexus3"` | no |
| <a name="input_private_subnets_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | List of Private Subnets IDs | `list(any)` | n/a | yes |
| <a name="input_public_subnets_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | List of Public Subnets IDs | `list(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region the infrastructure is hosted in | `any` | n/a | yes |
| <a name="input_s3_bucket_server_side_encryption_key"></a> [s3\_bucket\_server\_side\_encryption\_key](#input\_s3\_bucket\_server\_side\_encryption\_key) | (Optional) The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms. | `string` | `"aws/s3"` | no |
| <a name="input_s3_bucket_server_side_encryption_sse_algorithm"></a> [s3\_bucket\_server\_side\_encryption\_sse\_algorithm](#input\_s3\_bucket\_server\_side\_encryption\_sse\_algorithm) | (Optional) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"aws:kms"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nexus_lb_arn"></a> [nexus\_lb\_arn](#output\_nexus\_lb\_arn) | Sonatype Nexus Load Balancer ARN |
| <a name="output_nexus_lb_arn_suffix"></a> [nexus\_lb\_arn\_suffix](#output\_nexus\_lb\_arn\_suffix) | Sonatype Nexus Load Balancer ARN Suffix |
| <a name="output_nexus_lb_dns_name"></a> [nexus\_lb\_dns\_name](#output\_nexus\_lb\_dns\_name) | Sonatype Nexus Load Balancer DNS Name |
| <a name="output_nexus_lb_id"></a> [nexus\_lb\_id](#output\_nexus\_lb\_id) | Sonatype Nexus Load Balancer ID |
| <a name="output_nexus_lb_zone_id"></a> [nexus\_lb\_zone\_id](#output\_nexus\_lb\_zone\_id) | Sonatype Nexus Load Balancer Zone ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
