resource "aws_instance" "web" {
  ami           = "ami-0856ceeafc1be110c"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}",
    Itau = true
  }
}