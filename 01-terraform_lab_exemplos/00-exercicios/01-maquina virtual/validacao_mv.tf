
#    faça um script terraform que crie uma máquina na aws e solicite os dados abaixo validando
#    security group (validar o sg-)
#    subnet (validar o subnet-)
#    ami (validar o ami-)
#    instance_type (validar o t2.)


#    subnet_id = "subnet-02d7741675f030d69"
#    ami = "ami-083654bd07b5da81d"
#    instance_type = "t2.micro"
#    vpc_security_group_ids = ["sg-083654bd07b5da81d"]


provider "aws" {
  region = "sa-east-1"
}


resource "aws_instance" "web" {
  subnet_id = var.subnet_id
  ami= var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group]

  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-santi-tf-6" #${each.key}"
  }
}


variable "subnet_id" {
  type        = string
  description = "Qual é Subnet ID?"

  validation {
    condition     = substr(var.subnet_id, 0, 7) == "subnet-"
    error_message = "O valor do subnet_id nao e valido\"subnet-\"."
  }

}

variable "ami" {
  type        = string
  description = "Qual é a AMI?"

  validation {
    condition     = substr(var.ami, 0, 4) == "ami-"
    error_message = "O valor AMI não é valido\"ami-\"."
  }
}

variable "instance_type" {
  type        = string
  description = "Qual é Instance Type?"

  validation {
    condition     = substr(var.instance_type, 0, 3) == "t2."
    error_message = "O valor da Instancia nao e valido\"t2.\"."
  } 

}

variable "security_group" {
  type        = string
  description = "Qual é o Security Group?"
 # validation {
 #   condition     = substr(var.security_group, 0, 4) == "vpc-"
 #   error_message = "O valor do Security Group nao e valido\"vpc-\"."
 # }


}


