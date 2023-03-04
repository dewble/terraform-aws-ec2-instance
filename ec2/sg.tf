resource "aws_security_group" "jeff-sg" {
  name        = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = yamldecode(file(var.config_file)).aws_resources.vpc_id

  dynamic "ingress" {
    for_each = { for sg in yamldecode(file(var.config_file)).aws_security_group.ingress : sg.name => sg }
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = { for sg in yamldecode(file(var.config_file)).aws_security_group.egress : sg.name => sg }
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }


  tags = merge(
    yamldecode(file(var.config_file)).tags.common_tags,
    {
      Name = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-sg"
    },
  )
}


