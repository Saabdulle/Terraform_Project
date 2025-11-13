variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDR ranges"
}
variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDR ranges"
}
variable "availability_zones" {
  type = list(string)
}

variable "cidr_block" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "server_count" {
  type = number
}
variable "table_names" {
  type = list(string)
}
variable "table_tags" {
  type = list(string)
}
variable "server_names" {
  type = list(string)
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "desired_size" {
  type = number
}
# variable "target_group_ids" {
#   type = list(string)
# }
variable "ami_images" {
  type = list(string)
}
