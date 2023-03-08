# output "aws_accounts" {
#   value = yamldecode(file(var.config_file)).aws
# }

# output "backend" {
#   value = yamldecode(file(var.config_file)).remote_states.cloud
# }


# output "sg-tags" {
#   value = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-sg"
# }


output "public-ip" {
  value = aws_instance.jeff-ubuntu.public_ip
}
