

provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "EC2_Proj_Feriado" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "Treinamento-dia2-keypair"
  subnet_id               =  aws_subnet.my_subnet.id
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "EC2 Proj Feriado"
  }
}

output "EC2_Proj_Feriado" {
  value = [
    "ssh -i ~/.ssh/Treinamento-dia2-keypair.pem ubuntu@${aws_instance.EC2_Proj_Feriado.public_dns}",
    aws_instance.EC2_Proj_Feriado.public_dns,
    "ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/Treinamento-dia2-keypair.pem"
  ]
  description = "Mostra os IPs Publicos."
}


