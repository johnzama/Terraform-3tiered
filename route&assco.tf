# Route Table for Web Subnets (Public)
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Route to internet for public subnets
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "Web Route Table"
  }
}

# Associate Route Table with Web Subnets
resource "aws_route_table_association" "web_ass_01" {
  subnet_id      = aws_subnet.web_01.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_ass_02" {
  subnet_id      = aws_subnet.web_02.id
  route_table_id = aws_route_table.web_rt.id
}

# Route Table for App Subnets (Private with NAT)
resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "App Route Table"
  }
}

resource "aws_route_table_association" "app_ass_01" {
  subnet_id      = aws_subnet.app_01.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table_association" "app_ass_02" {
  subnet_id      = aws_subnet.app_02.id
  route_table_id = aws_route_table.app_rt.id
}

# Route Table for DB Subnets
resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "DB Route Table"
  }
}

resource "aws_route_table_association" "db_ass_01" {
  subnet_id      = aws_subnet.db_01.id
  route_table_id = aws_route_table.db_rt.id
}

resource "aws_route_table_association" "db_ass_02" {
  subnet_id      = aws_subnet.db_02.id
  route_table_id = aws_route_table.db_rt.id
}
