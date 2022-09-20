terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "web" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  tags = {
    Name = var.instance_name
  }
}