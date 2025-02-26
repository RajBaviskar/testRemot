# modules/serviceOne/variables.tf

variable "endpoint" {
  description = "The Harness API endpoint"
  type        = string
}

variable "account_id" {
  description = "The Harness account ID"
  type        = string
}

variable "platform_api_key" {
  description = "The Harness platform API key"
  type        = string
}

variable "harness_org_id" {
  description = "Harness organization ID"
  type        = string
}

variable "harness_project_id" {
  description = "Harness project ID"
  type        = string
}


