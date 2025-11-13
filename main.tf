module "Apps-Server" {
  source            = "./Modules/Apps-Server"
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.Security.security_group_id
  server_count      = var.server_count
  public_subnets    = module.Networking.public_subnets_ids
}
module "Networking" {
  source             = "./Modules/Networking"
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}
module "DynamoDB" {
  source      = "./Modules/DynamoDB"
  table_tags  = var.table_tags
  table_names = var.table_names
}
module "Security" {
  source = "./Modules/Security"
  vpc_id = module.Networking.vpc_id
}
