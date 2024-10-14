resource "aws_launch_template" "web_launch_template" {
  name_prefix = "web-instance"

  image_id      = "ami-0ea3c35c5c3284d82"  # Replace with your AMI
  instance_type = "t2.micro"

  key_name = aws_key_pair.web_key_pair.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Web Instance"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.web_01.id, aws_subnet.web_02.id]  # Web subnets

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Web Auto Scaling Group"
    propagate_at_launch = true
  }
}
