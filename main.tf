/* Networking */
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "demo-vpc"
  cidr = var.vpc-cidr-block
  azs             = [var.az1, var.az2, "ap-south-1c"]
  private_subnets = [var.public-subnet1, var.public-subnet2, var.public-subnet3]
  public_subnets  = [var.private-subnet1, var.private-subnet2,var.private-subnet3]
  enable_nat_gateway = true
  single_nat_gateway  = true
  one_nat_gateway_per_az = false
  tags = {
    Terraform = "true"
    Environment = "demo"
  }
}

######
## Launch configuration and autoscaling group
######
module "demo_asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  name = "demo-server"
  lc_name = "demo-lc"
  image_id        = lookup(var.INSTANCE_AMI, var.AWS_REGION) 
  instance_type   = "t2.micro"
  key_name = aws_key_pair.mykeypair.key_name
  security_groups = [ aws_security_group.demo_server_sg.id]
  load_balancers  = [module.elb.this_elb_id]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y && sudo apt install -y nginx
              sudo systemctl start nginx
              echo "<h1>Hello, This is a demo with Terraform</h1>" > /var/www/html/index.html
              sudo mkfs.ext4 /dev/xvdb
              sudo mkdir /var/oldlog
              sudo rsync -a --include '*/' /var/log/ /var/oldlog/
              sudo mount /dev/xvdb /var/log/
              sudo rsync -a --include '*/' /var/oldlog/ /var/log/
              EOF
  ebs_block_device = [
    {
      device_name           = "/dev/sdb"
      volume_type           = "gp2"
      volume_size           = "5"
      delete_on_termination = true
    },
  ]            
  root_block_device = [
    {
      volume_size = "10"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "demo-asg"
  vpc_zone_identifier       = [module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]]
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  
  tags = [
    {
      key                 = "Environment"
      value               = "demo"
      propagate_at_launch = true
    }
  ]
}

######
# ELB
######
module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name = "elb-demo"

  subnets         = [module.vpc.public_subnets[0],module.vpc.public_subnets[1],module.vpc.public_subnets[2]]
  security_groups = [aws_security_group.demo_alb_sg.id]
  internal        = false
  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Owner       = "user"
    Environment = "demo"
  }
}
