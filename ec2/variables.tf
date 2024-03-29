################################################
# Variables
################################################
variable "config_file" {
  description = "The path of configuration YAML file"
  type        = string
  default     = "./scripts/config.yaml"
}

variable "settings_file" {
  description = "The path of settings YAML file"
  type        = string
  default     = "./scripts/settings.yaml"
}

# variable "aws_security_group" {
#   type = list(object({
#     name        = string
#     description = string
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
#   default = yamldecode(file("./scripts/config.yaml")).aws_security_group.ingress
# }


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

