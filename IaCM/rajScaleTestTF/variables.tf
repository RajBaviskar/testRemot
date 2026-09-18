variable "resource_count" {
  type        = number
  default     = 200
  description = "How many terraform_data.hello instances. Start at 200. No cloud APIs, no files on disk."
}

variable "blob_kib" {
  type        = number
  default     = 4
  description = "KiB of dummy text on every instance (max 1024). This is what makes plan and state large."
}

variable "wave" {
  type        = string
  default     = "1"
  description = "Change this after the first apply (e.g. to 2) so the next plan has updates, not only creates."
}
