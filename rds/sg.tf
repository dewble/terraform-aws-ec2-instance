resource "aws_security_group" "jeff-sg" {
  name        = "${local.config.tags.common_tags.Project}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = local.config.aws_resources.vpc_id


  dynamic "ingress" {
    for_each = { for sg in local.config.aws_security_group.ingress : sg.name => sg }
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = { for sg in local.config.aws_security_group.egress : sg.name => sg }
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }


  tags = merge(
    local.config.tags.common_tags,
    {
      Name = "${local.config.tags.common_tags.Project}-sg"
    },
  )
}


# RDS 보안 그룹 설정
resource "aws_security_group" "example_security_group" {
  name_prefix = "example-security-group"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}