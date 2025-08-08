provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "ubuntu_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ubuntu_server" {
  ami             = "ami-02fda57d7882770d8"
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ubuntu_key.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "My-Ubuntu-Server"
  }
}

output "public_ip" {
  value = aws_instance.ubuntu_server.public_ip
}
