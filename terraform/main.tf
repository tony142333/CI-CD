provider "aws" {
  region = "us-east-1"  # Change this if you want a different region
}

# 1. Create a Security Group (Firewall)
resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, Jenkins, and App traffic"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Port
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # App Port (Node.js)
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic (Allow everything)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Create the Server (EC2 Instance)
resource "aws_instance" "devops_server" {
  ami           = "ami-0ecb62995f68bb549" # Ubuntu 22.04 LTS (us-east-1)
  instance_type = "t2.medium"             # Needed for Jenkins (t2.micro is too weak)
  key_name      = "vas"            # We will create this key manually in a second
  security_groups = [aws_security_group.devops_sg.name]

  tags = {
    Name = "Jenkins-Docker-Server"
  }
}

# 3. Print the IP Address at the end
output "server_ip" {
  value = aws_instance.devops_server.public_ip
}