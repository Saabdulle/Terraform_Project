variable "vpc_id" {
  type = string
}
variable "instance_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
