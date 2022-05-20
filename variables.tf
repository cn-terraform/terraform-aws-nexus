#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"
}

#------------------------------------------------------------------------------
# AWS REGION
#------------------------------------------------------------------------------
variable "region" {
  description = "AWS Region the infrastructure is hosted in"
}

#------------------------------------------------------------------------------
# AWS Networking
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of the VPC"
}

variable "availability_zones" {
  type        = list(any)
  description = "List of Availability Zones"
}

variable "public_subnets_ids" {
  type        = list(any)
  description = "List of Public Subnets IDs"
}

variable "private_subnets_ids" {
  type        = list(any)
  description = "List of Private Subnets IDs"
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER LOGS
#------------------------------------------------------------------------------
variable "enable_s3_logs" {
  description = "(Optional) If true, all resources to send LB logs to S3 will be created"
  type        = bool
  default     = true
}

variable "block_s3_bucket_public_access" {
  description = "(Optional) If true, public access to the S3 bucket will be blocked."
  type        = bool
  default     = true
}

variable "enable_s3_bucket_server_side_encryption" {
  description = "(Optional) If true, server side encryption will be applied."
  type        = bool
  default     = true
}

variable "s3_bucket_server_side_encryption_sse_algorithm" {
  description = "(Optional) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  type        = string
  default     = "aws:kms"
}

variable "s3_bucket_server_side_encryption_key" {
  description = "(Optional) The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
  type        = string
  default     = "aws/s3"
}

#------------------------------------------------------------------------------
# Nexus image version
#------------------------------------------------------------------------------
variable "nexus_image" {
  description = "Nexus image"
  type        = string
  default     = "sonatype/nexus3"
}
