resource "aws_key_pair" "my_key_pair" {
  key_name   = "switch-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "private-single-instance"

  ami                    = "ami-ff0fea8310f3"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  monitoring             = false
  vpc_security_group_ids = [module.private_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "public-single-instance"

  ami                    = "ami-ff0fea8310f3"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  monitoring             = false
  vpc_security_group_ids = [module.public_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}