#################### 작성내용 ####################
################################################
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

variable "policy_file" {
  description = "The path of policy JSON file"
  type        = string
  default     = "./scripts/policy.json"
}

