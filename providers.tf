terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.56.0, <4.59.0, !=4.43.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }   
  }
  required_version = "~>1.4.2"
}

provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
  # Configuration options
    default_tags {
      tags = var.tags
    }
}

