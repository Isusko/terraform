resource "aws_s3_bucket" "cerberus_bucket" {
  bucket = local.s3-sufix
}

resource "random_string" "sufijo-s3" {
  length = 8
  special = false
  upper = false
}

locals {
  s3-sufix = "${var.tags.project}-${random_string.sufijo-s3.id}"
} 