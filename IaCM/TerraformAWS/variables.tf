variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-05b10e08d247fb927"
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.large"
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "raj-tf-ec2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "raj-devspace3-tf-bucket"
}

# boolean type
variable "enable_versioning" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = false
}

# number type
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "max_retry_attempts" {
  description = "Maximum retry attempts for provisioning"
  type        = number
  default     = 3
}

# json/map type
variable "resource_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "instance_metadata" {
  description = "Metadata configuration for the instance (JSON object)"
  type = object({
    environment = string
    team        = string
    cost_center = string
  })
  default = {
    environment = "dev"
    team        = "platform"
    cost_center = "engineering"
  }
}

# json/list type
variable "allowed_cidrs" {
  description = "List of allowed CIDR blocks"
  type        = list(string)
  default     = []
}

variable "availability_zones" {
  description = "List of AZs to deploy into"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# number type (for testing IaCM number value_type)
variable "numbertemp" {
  description = "Temporary number variable for testing IaCM number value type"
  type        = number
  default     = 1.0
}

# complex json type
variable "scaling_config" {
  description = "Auto-scaling configuration as JSON"
  type = object({
    min_size     = number
    max_size     = number
    desired_size = number
    policies = list(object({
      name       = string
      threshold  = number
      adjustment = number
    }))
  })
  default = {
    min_size     = 1
    max_size     = 5
    desired_size = 2
    policies = [{
      name       = "scale-up"
      threshold  = 80
      adjustment = 1
    }]
  }
}
