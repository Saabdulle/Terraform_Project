resource "aws_launch_template" "app_lt" {
  count         = length(var.server_names)
  name          = "${var.server_names[count.index]}_service_app"
  image_id      = var.ami_images[count.index]
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    subnet_id                   = var.public_subnets[count.index]
    associate_public_ip_address = true
    security_groups             = [var.security_group_ids]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.server_names[count.index]}_launch_template_tag"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  count               = length(var.instance_ids)
  name                = "Autoscaling_group_${var.server_names[count.index]}"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_size
  vpc_zone_identifier = [var.public_subnets[count.index]]

  launch_template {
    id      = aws_launch_template.app_lt[count.index].id
    version = aws_launch_template.app_lt[count.index].latest_version

  }
}
resource "aws_autoscaling_attachment" "app_as_attach" {
  count                  = length(var.server_names)
  autoscaling_group_name = aws_autoscaling_group.app_asg[count.index].id
  lb_target_group_arn    = var.target_group_ids[count.index]

}
