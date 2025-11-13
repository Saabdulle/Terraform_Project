resource "aws_vpc" "tf_project" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "Terraform Project"
  }
}

# Public and Private Subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.tf_project.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = format("TF-Project public-%s", element(var.availability_zones, count.index))
  }
}
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.tf_project.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = format("TF-Project private-%s", element(var.availability_zones, count.index))
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf_project.id
  tags = {
    Name = "TF-Project igw"
  }
}

# Route Tables

# Public Table
resource "aws_route_table" "Public_table" {
  vpc_id = aws_vpc.tf_project.id

  tags = {
    Name = "TF-Project Public table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.Public_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.Public_table.id
}

# Private Table

# resource "aws_route_table" "Private_table" {
#   vpc_id = aws_vpc.tf_project.id

#   tags = {
#     Name = "TF-Project Private table"
#   }
# }

# resource "aws_route" "private_internet_gateway" {
#   route_table_id         = aws_route_table.Private_table.id
#   destination_cidr_block = "0.0.0.0/0"

# }

# resource "aws_route_table_association" "private" {
#   count          = length(var.private_subnets)
#   subnet_id      = element(aws_subnet.Private_subnets[*].id, count.index)
#   route_table_id = aws_route_table.private_table.id
# }

# Above is resource for private tables that will also need 
