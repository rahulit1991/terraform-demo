resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.key_path)
}
resource "aws_instance" "bastion-instance" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion-host.id]
  key_name = aws_key_pair.mykeypair.key_name
  tags = {
    Name = "bastion-instance"
  }
}
resource "aws_eip" "server_eip" {
  instance = aws_instance.bastion-instance.id
  vpc = true
  tags = {
    Name = "demo-server-EIP"
  }
}

