terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.0.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  allowed_account_ids = [var.aws_account_id]
  region              = var.aws_region
  profile             = var.aws_profile
}