terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ltsonforwork_testing"

    workspaces {
      name = "tfcloud"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  alias = "global"
  access_key = var.GLOBAL_AWS_ACCESS_KEY_ID
  secret_key = var.GLOBAL_AWS_SECRET_ACCESS_KEY
  region = "ap-southeast-1"
}

provider "aws" {
  alias = "minhem"
  access_key = var.minh_AWS_ACCESS_KEY_ID
  secret_key = var.minh_AWS_SECRET_ACCESS_KEY
  region = "ap-southeast-2"
}

resource "aws_vpc" "test1" {
  provider = aws.global
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "test1"
  }
}


resource "aws_vpc" "minhem" {
  provider = aws.minhem
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "minhem"
  }
}