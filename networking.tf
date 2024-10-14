resource "aws_vpc" "main-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main-vpc

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "web-01" {
  vpc_id     = aws_vpc.main-vpc
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "web-02" {
  vpc_id     = aws_vpc.main-vpc
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Public"
  }
}


resource "aws_subnet" "app-01" {
  vpc_id     = aws_vpc.main-vpc
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_subnet" "app-02" {
  vpc_id     = aws_vpc.main-vpc
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Private"
  }
}
resource "aws_subnet" "db-01" {
  vpc_id     = aws_vpc.main-vpc
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_subnet" "db-02" {
  vpc_id     = aws_vpc.main-vpc
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "Private"
  }
}

