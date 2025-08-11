terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "terraform-getting-started"
      Environment = "lab"
      ManagedBy   = "terraform"
      Module      = "ModuleTwo"
    }
  }
}
