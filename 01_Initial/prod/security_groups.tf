resource "aws_security_group" "lb_sg" {
  name        = "load_balancer_sg"
  description = "Load Balancer SG"
  vpc_id      = "vpc-8d1a53f7" ## Another Manual Change for a different deployment environment

  ingress {
    description = "http inbound for LB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Load Balancer SG"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "web_server_SG"
  description = "Allow inbound traffic from LB"
  vpc_id      = "vpc-8d1a53f7" ## Another Manual Change for a different deployment environment

  ingress {
    description     = "http inbound from LB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Web Server SG"
  }
}