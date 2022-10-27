resource "aws_key_pair" "testkey" {
  key_name   = var.key_name
  public_key = var.key
}

resource "aws_instance" "javaser" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.testkey.id
  vpc_security_group_ids = ["${aws_security_group.securitygroup.id}"]
  subnet_id              = aws_subnet.public-subnet.id
  tags = {
    Name = "javaser"
  }
  user_data = file("${path.module}/userdata.sh")
}