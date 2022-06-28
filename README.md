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
| <a name="module_aws_cw_logs"></a> [aws\_cw\_logs](#module\_aws\_cw\_logs) | cn-terraform/cloudwatch-logs/aws | 1.0.11 |
| <a name="module_ecs_fargate"></a> [ecs\_fargate](#module\_ecs\_fargate) | cn-terraform/ecs-fargate/aws | 2.0.42 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_s3_bucket_public_access"></a> [block\_s3\_bucket\_public\_access](#input\_block\_s3\_bucket\_public\_access) | (Optional) If true, public access to the S3 bucket will be blocked. | `bool` | `true` | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | If true a new KMS key will be created to encrypt the logs. Defaults true. If set to false a custom key can be used by setting the variable `log_group_kms_key_id` | `bool` | `false` | no |
| <a name="input_enable_s3_bucket_server_side_encryption"></a> [enable\_s3\_bucket\_server\_side\_encryption](#input\_enable\_s3\_bucket\_server\_side\_encryption) | (Optional) If true, server side encryption will be applied. | `bool` | `true` | no |
| <a name="input_enable_s3_logs"></a> [enable\_s3\_logs](#input\_enable\_s3\_logs) | (Optional) If true, all resources to send LB logs to S3 will be created | `bool` | `true` | no |
| <a name="input_log_group_kms_key_id"></a> [log\_group\_kms\_key\_id](#input\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested. | `string` | `null` | no |
| <a name="input_log_group_retention_in_days"></a> [log\_group\_retention\_in\_days](#input\_log\_group\_retention\_in\_days) | (Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. Default to 30 days. | `number` | `30` | no |
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
