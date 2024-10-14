# Elastic IP for NAT Gateway
resource "aws_eip" "main_eip" {
  vpc = true
}

# NAT Gateway (Place in Public Subnet)
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.main_eip.id
  subnet_id     = aws_subnet.web_01.id  # Place the NAT Gateway in the public subnet

  tags = {
    Name = "Main NAT Gateway"
  }
}
