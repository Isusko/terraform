resource "aws_vpc" "vpc_virginia" {
   cidr_block = var.virginia_cidr
  tags = {
    Name = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[0] ##Aquí modificamos var.public_subnet, ahora que ocupamos 1 lista lo mandamos a llamar por posición
  map_public_ip_on_launch = true
 tags = {
    Name = "Public Subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
 cidr_block = var.subnets[1] ##Aquí modificamos var.public_subnet, ahora que ocupamos 1 lista lo mandamos a llamar por posición
 tags = {
    Name = "Private Subnet-${local.sufix}"
  }
depends_on = [
  aws_subnet.public_subnet
]
}
##Recurso internet Gateway
resource "aws_internet_gateway" "igw"  {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

##Recurso Route Table
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

   dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  } 
/*   ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.sg_ingress_cidr]
    ##ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block] Aquí no usamos IPv6
  }

    ingress {
    description      = "http over internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.sg_ingress_cidr]
    ##ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block] Aquí no usamos IPv6
  } */

 /*     ingress {
    description      = "https over internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.sg_ingress_cidr]
    ##ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block] Aquí no usamos IPv6
  }
 */
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }
}