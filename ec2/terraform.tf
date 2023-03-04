#################### 작성내용 ####################
# - `backend` 설정
#   - A backend block cannot refer to named values (like input variables, locals, or data source attributes).
#   - multi backend 설정 가능
# - `Local Variables`해당 workspace에서 사용하는 지역변수 정의
#     - `yamldecode(file)`
#         - function을 이용하면 HCL object로 변환하여 사용할 수 있다.(read file)
#     - `yamldecode(templatefile)`
#         - file을 불러올때 context variable을 전달하여 template을 렌더링할 수 있다 → ${vpc}, ${cidrs.primary}
# - `Providers` 설정
# - `versions` 설정
#   - terraform block을 통해 required_version에 해당 workspace를 구동하기 위한 terraform 버전을 기재
#   - required_providers block을 이용하여 사용하는 providers의 버전 기재
################################################
# ################################################
# # remote_states
# # = state storage
# ################################################
terraform {
  cloud {
    organization = "dewble"
    workspaces {
      name = "aws-ec2"
    }
  }
  # s3 {
  #   bucket = "jeff-terraform-backend"
  #   key    = "s3-backend/terraform.tfstate"
  #   region = "ap-northeast-2"
  # }
}

###################################################
# Versions
###################################################
terraform {
  required_version = "~> 1.3.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

################################################
# Local Variables
################################################

###################################################
# Providers
###################################################
provider "aws" {
  region = yamldecode(file(var.settings_file)).aws.region

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [yamldecode(file(var.settings_file)).aws.id]
}