resource "aws_instance" "lighting_app_server" {
  instance_type               = var.instance_type
  key_name                    = var.key_name
  ami                         = "ami-0505148b3591e4c07"
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.public_subnets[0]
  associate_public_ip_address = true
  tags = {
    Name = "Lighting App Server"
  }
}
resource "aws_instance" "heating_app_server" {
  instance_type               = var.instance_type
  key_name                    = var.key_name
  ami                         = "ami-0505148b3591e4c07"
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.public_subnets[1]
  associate_public_ip_address = true
  tags = {
    Name = "Heating App Server"
  }
}
resource "aws_instance" "status_app_server" {
  instance_type = var.instance_type
  key_name      = var.key_name
  ami           = "ami-0505148b3591e4c07"
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.public_subnets[2]
  associate_public_ip_address = true
  tags = {
    Name = "Status App Server"
  }
}
