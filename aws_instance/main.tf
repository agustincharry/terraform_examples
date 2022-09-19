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


resource "aws_iam_policy" "ECRAuthTokenPolicy" {
  name        = "ECRAuthTokenPolicy"
  path        = "/"
  description = "Policy used to allow login against ECR"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : [
          "ecr:GetAuthorizationToken"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "EC2InstanceRole" {
  name                = "EC2InstanceRole"
  path                = "/"
  managed_policy_arns = [
    aws_iam_policy.ECRAuthTokenPolicy.arn,
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_instance_profile" "EC2InstanceProfile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.EC2InstanceRole.name
}


resource "aws_instance" "app_server" {
  ami                  = "ami-05fa00d4c63e32376"
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.EC2InstanceProfile.name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
