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
# Nexus image version
#------------------------------------------------------------------------------
variable "nexus_image" {
  description = "Nexus image"
  type        = string
  default     = "sonatype/nexus3"
}
