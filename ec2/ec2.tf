resource "aws_instance" "jeff-ubuntu" {
  depends_on = [
    aws_security_group.jeff-sg
  ]
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = local.config.aws_resources.instanace_type
  subnet_id            = local.config.aws_resources.sub_pub_man_a_id
  iam_instance_profile = "session-manager-instance-profile"
  key_name             = local.config.aws_resources.key_name
  # user_data     = "${file("${local.scripts_path}/initial-install.sh")}"
  user_data = local.script_initial-install

  tags = merge(
    local.config.tags.common_tags,
    {
      Name = "${local.config.tags.common_tags.Project}-ec2"
    },
  )
  security_groups = [aws_security_group.jeff-sg.id]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
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
