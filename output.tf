output "vpc_id" {
  value = module.Networking.vpc_id
}
output "instance_id" {
  value = module.Apps-Server.instance_ids
}
output "target_group_ids" {
  value = module.Load-Balancer.target_group_ids
}
