provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
provider "http" {}