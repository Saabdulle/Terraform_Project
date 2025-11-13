variable "instance_type" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
variable "key_name" {
  type = string
}
variable "server_count" {
  type = string
}
