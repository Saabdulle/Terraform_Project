module "Apps-Server" {
  source            = "./Modules/Apps-Server"
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.Security.security_group_id
  server_count      = var.server_count
  public_subnets    = module.Networking.public_subnets_ids
}
