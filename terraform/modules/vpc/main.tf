//Networking CFG
resource "aws_vpc" "avantio_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "avantio-vpc-${var.env}-${var.region}"
  }
}

//Public Subnets cfg
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.avantio_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}a" 
  map_public_ip_on_launch = true
  tags = {
    Name = "avantio-public-subnet-1-${var.env}-${var.region}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.avantio_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.region}b" 
  map_public_ip_on_launch = true
  tags = {
    Name = "avantio-public-subnet-2-${var.env}-${var.region}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.avantio_vpc.id
  tags = {
    Name = "avantio-igw-${var.env}-${var.region}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.avantio_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "avantio-public-route-table-${var.env}-${var.region}"
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

//Private Subnets cfg
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.avantio_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "avantio-private-subnet-1-${var.env}-${var.region}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.avantio_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "avantio-private-subnet-2-${var.env}-${var.region}"
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "avantio-nat-gateway-${var.env}-${var.region}"
  }

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.avantio_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "avantio-private-route-table-${var.env}-${var.region}"
  }
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}