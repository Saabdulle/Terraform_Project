output "vpc_id" {
  value = aws_vpc.tf_project.id
}
output "public_subnets_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}
output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}
