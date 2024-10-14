# Web Tier Security Group (Allow HTTP/HTTPS)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP/HTTPS inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any IP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}


# App Tier Security Group (Allow traffic from Web tier)
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow traffic from Web Tier"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
  # Only allow traffic from Web SG
  }

  ingress {
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}


# DB Tier Security Group (Allow traffic from App tier)
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow traffic from App Tier"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port                = 3306  # MySQL port (use appropriate port for your DB)
    to_port                  = 3306
    protocol                 = "tcp"
      # Only allow traffic from App SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}


