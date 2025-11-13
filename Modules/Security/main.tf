data "http" "myipaddr" {
  url = "http://icanhazip.com"
}
resource "aws_security_group" "app_server" {
  name        = "TF-Project app_server SG"
  description = "Project securt group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6" {
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv6         = "::/0"
  security_group_id = aws_security_group.app_server.id
}
resource "aws_vpc_security_group_ingress_rule" "http_ipv4" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "https_ipv6" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "https_ipv4_ipv4" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv4         = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv6" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv4" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
resource "aws_vpc_security_group_ingress_rule" "ipv6-3000" {
  cidr_ipv6        = "::/0"
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.app_server.id
}
resource "aws_vpc_security_group_ingress_rule" "ipv4-3000" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.app_server.id
}
