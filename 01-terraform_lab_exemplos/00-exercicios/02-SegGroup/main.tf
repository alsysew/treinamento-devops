provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0856ceeafc1be110c"
  instance_type = "t2.micro"
  key_name = "Treinamento-dia2-keypair" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  subnet_id = "subnet-0f4dc32624c2fb345"
  associate_public_ip_address = true
  tags = {
    Name = "Maquina EC2 exercicio 02"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}

output "instance_public_dns" {
  value = [
    aws_instance.web.public_dns, 
    aws_instance.web.public_ip, 
    aws_instance.web.private_ip,
    "ssh -i ~/.ssh/Treinamento-dia2-keypair.pem ubuntu@${aws_instance.web.public_dns}"

  ]
  description = "Mostra os IPs publicos e privados da maquina criada."
}