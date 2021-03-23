provider "aws" {
  region = "eu-north-1" 
}


resource "aws_instance" "amazon_linux_for_exam" {
  ami                    = "ami-076c2ee28e3f9f38e"                  
  instance_type          = "t3.large"
  vpc_security_group_ids = [aws_security_group.server_app_sg.id]
  key_name               = "new_stockholm"
  user_data              = file("install_elk.sh")

  tags = {
    Name  = "ELK-Kafka"
    Owner = "Alexander Efimov"
  }
}


resource "aws_security_group" "server_app_sg" {
  name = "server_app_calc_security_group"

  ingress {
    description = "open 5601 port"
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "open 22 port"
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
