variable "instance_ids" {
  type = list(string)
}
variable "server_names" {
  type = list(string)
}
variable "security_group_ids" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "key_name" {
  type = string
}
variable "instance_type" {
  type = string
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
variable "target_group_ids" {
  type = list(string)
}
variable "ami_images" {
  type = list(string)
}
