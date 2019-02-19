variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  default     = "prod"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  default     = "kfsolutions-terraform-up-and-running-state"
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  default     = "prod/data-stores/mysql/terraform.tfstate"
}
