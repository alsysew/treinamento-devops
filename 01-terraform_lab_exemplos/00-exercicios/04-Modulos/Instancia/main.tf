provider "aws" {
  region = "sa-east-1"
}


resource "aws_instance" "web" {
  ami           = "ami-0856ceeafc1be110c"
  instance_type = "t2.micro"
  key_name = "Treinamento-dia2-keypair"
  associate_public_ip_address = true
  subnet_id = "subnet-0f4dc32624c2fb345"
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}",
    Itau = true
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}


resource "aws_security_group" "allow_ssh" {
#  name        = "allow_ssh"
#  description = "Allow SSH inbound traffic"
  vpc_id= "vpc-07d2b7ba3dfc13689"
}
#      ingress = [
#        {
#          description      = "SSH from VPC"
#          from_port        = 22
#          to_port          = 22
#          protocol         = "tcp"
#          cidr_blocks      = ["0.0.0.0/0"]
#          ipv6_cidr_blocks = ["::/0"]
#          prefix_list_ids = null,
#          security_groups = null,
#          self            = null
#        },
#        {
#          description      = "SSH from VPC"
#          from_port        = 80
#          to_port          = 80
#          protocol         = "tcp"
#          cidr_blocks      = ["0.0.0.0/0"]
#          ipv6_cidr_blocks = ["::/0"]
#          prefix_list_ids = null,
#          security_groups = null,
#          self            = null
#        }
#      ]
#
#      egress = [
#        {
#          from_port        = 0
#          to_port          = 0
#          protocol         = "-1"
#          cidr_blocks      = ["0.0.0.0/0"]
#          ipv6_cidr_blocks = ["::/0"],
#          prefix_list_ids  = null,
#          security_groups  = null,
#          self             = null,
#          description      = "Libera dados da rede interna"
#        }
#      ]

#      tags = {
#        Name = "allow_ssh"
#      }
#    }