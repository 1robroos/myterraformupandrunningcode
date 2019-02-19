provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key    = "${var.db_remote_state_key}"
  instance_type          = "t2.medium"
}

terraform {
  backend "s3" {
    bucket = "kfsolutions-terraform-up-and-running-state"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}
