#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
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

variable "public_subnets_ids" {
  type        = list(any)
  description = "List of Public Subnets IDs"
}

variable "private_subnets_ids" {
  type        = list(any)
  description = "List of Private Subnets IDs"
}

variable "lb_enable_cross_zone_load_balancing" {
  type        = string
  default     = "true"
  description = "Enable cross zone support for LB"
}

variable "lb_http_ports" {
  description = "Map containing objects to define listeners behaviour based on type field. If type field is `forward`, include listener_port and the target_group_port. For `redirect` type, include listener port, host, path, port, protocol, query and status_code. For `fixed-response`, include listener_port, content_type, message_body and status_code"
  type        = map(any)
  default     = {}
}

variable "lb_https_ports" {
  description = "Map containing objects to define listeners behaviour based on type field. If type field is `forward`, include listener_port and the target_group_port. For `redirect` type, include listener port, host, path, port, protocol, query and status_code. For `fixed-response`, include listener_port, content_type, message_body and status_code"
  type        = map(any)
  default = {
    default = {
      listener_port         = 443
      target_group_port     = 8081
      target_group_protocol = "HTTP"
    }
  }
}

variable "lb_waf_web_acl_arn" {
  description = "ARN of a WAFV2 to associate with the ALB"
  type        = string
  default     = ""
}

#------------------------------------------------------------------------------
# CloudWatch logs
#------------------------------------------------------------------------------
variable "create_kms_key" {
  description = "If true a new KMS key will be created to encrypt the logs. Defaults true. If set to false a custom key can be used by setting the variable `log_group_kms_key_id`"
  type        = bool
  default     = false
}

variable "log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  type        = string
  default     = null
}

variable "log_group_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. Default to 30 days."
  type        = number
  default     = 30
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER LOGS
#------------------------------------------------------------------------------
variable "custom_lb_arn" {
  description = "ARN of the Load Balancer to use in the ECS service. If provided, this module will not create a load balancer and will use the one provided in this variable"
  type        = string
  default     = null
}

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
  default     = "AES256"
}

variable "s3_bucket_server_side_encryption_key" {
  description = "(Optional) The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
  type        = string
  default     = null
}

#------------------------------------------------------------------------------
# Nexus image version
#------------------------------------------------------------------------------
variable "nexus_image" {
  description = "Nexus image"
  type        = string
  default     = "sonatype/nexus3"
}

variable "container_cpu" {
  description = "(Optional) The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  type        = number
  default     = 4096
}

variable "container_memory" {
  description = "(Optional) The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  type        = number
  default     = 8192
}

variable "container_memory_reservation" {
  description = "(Optional) The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  type        = number
  default     = 4096
}

variable "deployment_circuit_breaker_enabled" {
  description = "(Optional) You can enable the deployment circuit breaker to cause a service deployment to transition to a failed state if tasks are persistently failing to reach RUNNING state or are failing healthcheck."
  type        = bool
  default     = false
}

variable "deployment_circuit_breaker_rollback" {
  description = "(Optional) The optional rollback option causes Amazon ECS to roll back to the last completed deployment upon a deployment failure."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Nexus storage settings
#------------------------------------------------------------------------------

variable "ephemeral_storage_size" {
  type        = number
  description = "The number of GBs to provision for ephemeral storage on Fargate tasks. Must be greater than or equal to 21 and less than or equal to 200"
  default     = 0
}

variable "volumes" {
  description = "(Optional) A set of volume blocks that containers in your task may use"
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = string
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))
  default = []
}

variable "mount_points" {
  type = list(any)

  description = "Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`. The `readOnly` key is optional."
  default     = []
}

#------------------------------------------------------------------------------
# Nexus SSL settings
#------------------------------------------------------------------------------

variable "configure_loadbalancer_ssl" {
  type = object({
    enable_ssl               = bool
    dns_zone_id              = string
    https_record_name        = string
    https_record_domain_name = string
  })
  description = "Enable SSL, and configure the loadbalancer to use the certificate"
  default = {
    enable_ssl               = false
    dns_zone_id              = ""
    https_record_name        = ""
    https_record_domain_name = ""
  }
}
