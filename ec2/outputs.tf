output "public-ip" {
  value = aws_instance.jeff-ubuntu.public_ip
}

output "instance_id" {
  value = aws_instance.jeff-ubuntu.id
  description = "ID of the created EC2 instance"
}