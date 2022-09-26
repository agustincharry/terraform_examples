provider "aws" {
  region = "us-east-1"
}

module "ec2_module" {
  source = "./ec2_module"

  instance_type = "t3.micro"
  instance_ami  = "ami-05fa00d4c63e32376"
  instance_name = "ExampleServer"
}

output "id" {
  description = "The ID of the instance"
  value       = module.ec2_module.id
}
