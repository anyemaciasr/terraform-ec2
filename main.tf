provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

data "aws_ami" "ubuntu" {
    most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "clave"

  tags = {
    Name = "web-server"
  }
}

output "public_ip" {
  value       = aws_instance.web.public_ip
}