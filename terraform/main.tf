provider "aws" {
  region = "us-east-1"
}

# 1. Security Group: Open Port 80 (Web) and 22 (SSH)
resource "aws_security_group" "auto_deploy_sg" {
  name        = "auto-deploy-sg"
  description = "Allow Web and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Web App"
    from_port   = 80
    to_port     = 80
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

# 2. The Server
resource "aws_instance" "app_server" {
  ami           = "ami-04b4f1a9cf54c11d0" # Ubuntu 24.04 (US-East-1)
  instance_type = "t2.micro"
  key_name      = "vas"  # <--- MAKE SURE THIS MATCHES YOUR AWS KEY NAME
  security_groups = [aws_security_group.auto_deploy_sg.name]

  # This script runs automatically when the server turns on
  user_data = <<-EOF
              #!/bin/bash

              # 1. Install Docker
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu

              # 2. Login to Docker Hub (OPTIONAL - Only needed if repo is private)
              # REPLACE 'your_password' and 'tarun142333' below
              # echo "your_actual_password_here" | docker login -u "tarun142333" --password-stdin

              # 3. Pull and Run the App
              # Mapping Port 80 (Public) -> 3000 (Container Internal)
              docker run -d -p 80:3000 --name devops-app --restart always tarun142333/my-devops-app:latest
              EOF

  tags = {
    Name = "Automated-DevOps-Server"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}