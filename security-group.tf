resource "aws_security_group" "bastion-host" {
  vpc_id = module.vpc.vpc_id
  name = "bastion-sg"
  description = "created by terraform"

  ingress {
    description = "SSH from ALL"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-sg"
  }
}
# Instance Security Groups
resource "aws_security_group" "demo_server_sg" {
  vpc_id = module.vpc.vpc_id
  name = "demo-sg"
  description = "created by terraform"

  ingress {
    description = "HTTP from ALL"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    security_groups = [aws_security_group.demo_alb_sg.id]
  }
  ingress {
    description = "SSH from Bastion Server"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = [aws_security_group.bastion-host.id]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "demo-sg"
  }
}

# ALB Security Group
resource "aws_security_group" "demo_alb_sg" {
  vpc_id = module.vpc.vpc_id
  name = "demo-alb-sg"
  description = "created by terraform"
  ingress {
    description = "Access from Application Server"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-demo-sg"
  }
}