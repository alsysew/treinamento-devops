resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "TerraformVPCPublicSubnet"
  }
}

resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "tf-lab-santi-subnet1"
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "tf-lab-santi-subnet2"
  }
}

resource "aws_subnet" "my_subnet3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.60.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "tf-lab-santi-subnet3"
  }
}

resource "aws_subnet" "my_subnet_priv" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.80.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "tf-lab-santi-subnet-privada"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "aws_internet_gateway_terraform"
  }
}

resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
      {
        carrier_gateway_id         = ""
        cidr_block                 = "0.0.0.0/0"
        destination_prefix_list_id = ""
        egress_only_gateway_id     = ""
        gateway_id                 = aws_internet_gateway.gw.id
        instance_id                = ""
        ipv6_cidr_block            = ""
        local_gateway_id           = ""
        nat_gateway_id             = ""
        network_interface_id       = ""
        transit_gateway_id         = ""
        vpc_endpoint_id            = ""
        vpc_peering_connection_id  = ""
      }
  ]

  tags = {
    Name = "route_table_terraform"
  }
}


resource "aws_route_table" "rt_priv" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
  ]

  tags = {
    Name = "route_table_Privada"
  }
}



resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.my_subnet3.id
  route_table_id = aws_route_table.rt_terraform.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.my_subnet_priv.id
  route_table_id = aws_route_table.rt_priv.id
}



# resource "aws_network_interface" "my_subnet" {
#   subnet_id           = aws_subnet.my_subnet.id
#   private_ips         = ["172.17.10.100"] # IP definido para instancia
#   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

#   tags = {
#     Name = "primary_network_interface my_subnet"
#   }
# }