provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  tags = {
    Name = "Maquina de Teste EC2"
  }
}