resource "aws_security_group" "web-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main-vpc

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.web-sg
  cidr_ipv4         = aws_vpc.main-vpc
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.web-sg
  cidr_ipv6         = aws_vpc.main-vpc
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web-sg
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.web-sg
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}







resource "aws_security_group" "app-sg" {
  name        = "app-sg"
  description = "Allow traffic from the web tier"
  vpc_id      = aws_vpc.main-vpc.id

  tags = {
    Name = "app-sg"
  }
}

# Ingress rule to allow traffic from the web tier to the app tier
resource "aws_security_group_rule" "allow_web_to_app" {
  security_group_id        = aws_security_group.app-sg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "allow_web_to_app_https" {
  security_group_id        = aws_security_group.app-sg.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web-sg.id
}

# Egress: Allow all outbound traffic from the app tier
resource "aws_security_group_rule" "app_allow_all_egress" {
  security_group_id = aws_security_group.app-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}





resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow traffic from the app tier to the database"
  vpc_id      = aws_vpc.main-vpc.id

  tags = {
    Name = "db-sg"
  }
}

# Ingress: Allow app tier to connect to the database
resource "aws_security_group_rule" "allow_app_to_db" {
  security_group_id        = aws_security_group.db-sg.id
  type                     = "ingress"
  from_port                = 3306 # Change to your DB port
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app-sg.id
}

# Egress: Allow all outbound traffic from DB tier (or restrict if needed)
resource "aws_security_group_rule" "db_allow_all_egress" {
  security_group_id = aws_security_group.db-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
