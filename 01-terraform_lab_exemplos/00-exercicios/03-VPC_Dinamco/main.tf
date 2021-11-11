#    criar uma VPC com 4 subnet as zonas fica ao critério de vcs
#    3 subnets com internet gatway e uma, sem internet
#    Irão criar 3 instancias de maquinas 3 em subnets com acesso a internet
#    e uma sem acesso a internet
#
#    Verificar tentando acessar a máquina com ssh


provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web1" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "Treinamento-dia2-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet1.id # vincula a subnet direto e gera o IP automático
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "WEB1 VPC do terraform"
  }
}

resource "aws_instance" "web2" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "Treinamento-dia2-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet2.id # vincula a subnet direto e gera o IP automático
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "WEB2 VPC do terraform"
  }
}

resource "aws_instance" "web3" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "Treinamento-dia2-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet2.id # vincula a subnet direto e gera o IP automático
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "WEB3 VPC do terraform"
  }
}

resource "aws_instance" "web_priv" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "Treinamento-dia2-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet_priv.id # vincula a subnet direto e gera o IP automático
  root_block_device {
    encrypted = true
    volume_size = 8
  }

  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "WEB_Priv VPC do terraform"
  }
}




output "instance_ip_web1" {
  value = [
    aws_instance.web1.public_dns, 
    aws_instance.web1.public_ip, 
    aws_instance.web1.private_ip,
    "ssh -i ~/.ssh/Treinamento-dia2-keypair.pem ubuntu@${aws_instance.web1.public_dns}"
  ]
  description = "Mostra os IPs Web1."
}

output "instance_ip_web2" {
  value = [
    aws_instance.web2.public_dns, 
    aws_instance.web2.public_ip, 
    aws_instance.web2.private_ip,
    "ssh -i ~/.ssh/Treinamento-dia2-keypair.pem ubuntu@${aws_instance.web2.public_dns}"
  ]
  description = "Mostra os IPs Web2."
}

output "instance_ip_web3" {
  value = [
    aws_instance.web3.public_dns, 
    aws_instance.web3.public_ip, 
    aws_instance.web3.private_ip,
    "ssh -i ~/.ssh/Treinamento-dia2-keypair.pem ubuntu@${aws_instance.web3.public_dns}"
  ]
  description = "Mostra os IPs Web3."
}


output "instance_ip_web_priv" {
  value = [
    aws_instance.web_priv.public_dns, 
    aws_instance.web_priv.public_ip, 
    aws_instance.web_priv.private_ip,
    "ssh -i ~/.ssh/Treinamento-dia2-keypair.pem ubuntu@${aws_instance.web_priv.public_dns}"
  ]
  description = "Mostra os IPs Web_priv."
}




#    resource "aws_eip" "example" {
#      vpc = true
#    }

#    resource "aws_eip_association" "eip_assoc" {
#      instance_id   = aws_instance.web.id
#      allocation_id = aws_eip.example.id
#    }

# terraform refresh para mostrar o ssh

#    output "aws_instance_e_ssh" {
#      value = [
#        aws_instance.web.public_ip,
#        "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.web.public_dns}"
#      ]
#    }