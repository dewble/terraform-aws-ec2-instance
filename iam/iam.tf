# resource "aws_iam_role" "jeff-role" {
#   name = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-role"
#   tags = merge(
#     yamldecode(file(var.config_file)).tags.common_tags,
#     {
#       Name = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-role"
#     },
#   )
#   assume_role_policy = jsonencode(file(var.policy_file))
# }

# resource "aws_iam_role_policy_attachment" "session_manager_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.jeff-role.name
# }

# Create a new IAM role
resource "aws_iam_role" "jeff-role" {
  name = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-role"
  tags = merge(
    yamldecode(file(var.config_file)).tags.common_tags,
    {
      Name = "${yamldecode(file(var.config_file)).tags.common_tags.Project}-role"
    },
  )

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ssm.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create a new IAM policy to attach to the role
resource "aws_iam_policy" "session_manager_policy" {
  name = "session-manager-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ssm:StartSession",
          "ssm:TerminateSession",
          "ssm:ResumeSession"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "session_manager_role_policy_attachment" {
  policy_arn = aws_iam_policy.session_manager_policy.arn
  role       = aws_iam_role.jeff-role.name
}

# Create an instance profile for the role
resource "aws_iam_instance_profile" "session_manager_instance_profile" {
  name = "session-manager-instance-profile"
  role = aws_iam_role.jeff-role.name
}
