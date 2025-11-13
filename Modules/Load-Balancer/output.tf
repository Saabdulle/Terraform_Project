output "target_group_ids" {
  value = [aws_lb_target_group.lights_lb_tg.arn, aws_lb_target_group.heating_lb_tg.arn, aws_lb_target_group.status_lb_tg.arn]
}
