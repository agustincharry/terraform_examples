
resource "aws_iam_role" "this" {
  name = "EC2InstanceRole"
  path = "/"
  managed_policy_arns = [
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


resource "aws_iam_instance_profile" "this" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.this.name
}


resource "aws_instance" "this" {
  ami                  = var.instance_ami
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.this.name
  tags = {
    Name = var.instance_name
  }
}
