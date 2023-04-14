# Configure the AWS provider
provider "aws" {
  region = "us-west-2" # change to your desired region
}

# Create a new security group
resource "aws_security_group" "nginx_sg" {
  name_prefix = "nginx_sg"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a new key pair
resource "aws_key_pair" "my_keypair" {
  key_name   = "my-keypair" # change to your desired keypair name

  # change this to the path to your own public key file
  public_key = file("~/.ssh/id_rsa.pub") 
}

# Launch an EC2 instance
resource "aws_instance" "nginx_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_keypair.key_name # use the keypair name defined above
  security_groups = [aws_security_group.nginx_sg.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa") # change to your desired private key file
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install nginx1.12",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  tags = {
    Name = "nginx-instance"
  }
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.nginx_instance.public_ip
}
