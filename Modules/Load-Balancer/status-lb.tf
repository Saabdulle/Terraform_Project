resource "aws_lb_target_group" "status_lb_tg" {
  name             = "status-tg"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  target_type      = "instance"
  health_check {
    path     = "/api/status/health"
    port     = 3000
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "status_app_lb_tg_attach" {
  target_group_arn = aws_lb_target_group.status_lb_tg.arn
  target_id        = var.instance_ids[2]
  port             = 3000
}

resource "aws_lb_listener_rule" "status_lb_rule" {
  listener_arn = aws_lb_listener.app_lb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status_lb_tg.arn
  }
  condition {
    path_pattern {
      values = ["api/status/*"]
    }
  }
}
