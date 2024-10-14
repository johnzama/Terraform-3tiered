# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main"
  }
}

# Subnets for Web, App, and DB tiers
resource "aws_subnet" "web_01" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public Web"
  }
}

resource "aws_subnet" "web_02" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Public Web"
  }
}

resource "aws_subnet" "app_01" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Private App"
  }
}

resource "aws_subnet" "app_02" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Private App"
  }
}

resource "aws_subnet" "db_01" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "Private DB"
  }
}

resource "aws_subnet" "db_02" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "Private DB"
  }
}
