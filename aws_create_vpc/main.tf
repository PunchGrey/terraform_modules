data "aws_availability_zones" "available" {}

resource "aws_vpc" "name" {
  cidr_block = var.cidr_block_vpc
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.name.id
    cidr_block = var.private_subnet_cidr[count.index]
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.env}-private-${count.index}"
    }
    availability_zone = data.aws_availability_zones.available.names[count.index]
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.name.id
    cidr_block = var.public_subnet_cidr[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.env}-public-${count.index}"
    }
    availability_zone = data.aws_availability_zones.available.names[count.index]
}

resource "aws_internet_gateway" "gw_internet" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "gw-${var.env}"
  }
}


resource "aws_route_table" "rt_internet" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_internet.id
  }

  tags = {
    Name = "${var.env}_rt_internet"
  }
}

resource "aws_route_table_association" "a" {
  count =length(var.public_subnet_cidr)
  
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.rt_internet.id
}