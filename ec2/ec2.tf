resource "aws_instance" "jeff-ubuntu" {
  depends_on = [
    aws_security_group.jeff-sg
  ]
  ami           = data.aws_ami.ubuntu.id
  instance_type = yamldecode(file(var.config_file)).aws_resources.instanace_type
  subnet_id     = yamldecode(file(var.config_file)).aws_resources.sub_pub_man_a_id
  key_name      = yamldecode(file(var.config_file)).aws_resources.key_name
  user_data     = file("${path.module}/scripts/initial-install.sh")

  tags = merge(
    yamldecode(file(var.config_file)).tags.common_tags,
    {
      Name = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-ec2"
    },
  )
  security_groups = [aws_security_group.jeff-sg.id]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
