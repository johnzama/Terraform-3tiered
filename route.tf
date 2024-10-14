resource "aws_egress_only_internet_gateway" "main_eigw" {
  vpc_id = aws_vpc.main-vpc

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "webb-rt" {
  vpc_id = aws_vpc.main-vpc

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.main_igw
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.main_eigw
  }

  tags = {
    Name = "web-rt"
  }
}

resource "aws_route_table_association" "webb-ass-01" {
  subnet_id      = aws_subnet.web-01.id
  route_table_id = aws_route_table.webb-rt.id
}

resource "aws_route_table_association" "webb-ass-02" {
  subnet_id      = aws_subnet.web-02.id
  route_table_id = aws_route_table.webb-rt.id
}

resource "aws_route_table" "app-rt" {
  vpc_id = aws_vpc.main-vpc

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.main_igw
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.main_eigw
  }

  tags = {
    Name = "app-rt"
  }
}

resource "aws_route_table_association" "app-ass-01" {
  subnet_id      = aws_subnet.app-01
  route_table_id = aws_route_table.app-rt
}

resource "aws_route_table_association" "app-ass-02" {
  subnet_id      = aws_subnet.app-02
  route_table_id = aws_route_table.app-rt
}

resource "aws_route_table" "db-rt" {
  vpc_id = aws_vpc.main-vpc

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.main_igw
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.main_eigw
  }

  tags = {
    Name = "db-rt"
  }
}

resource "aws_eip" "main-aws_eip" {
  instance = aws_instance.web.id
  domain   = "vpc"
}

resource "aws_nat_gateway" "main-nat" {
  allocation_id = aws_eip.main-aws_eip
  subnet_id     = aws_subnet.web-01

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main_igw]
}
