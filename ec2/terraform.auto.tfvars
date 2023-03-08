#################### 작성내용 ####################
# 아래와 같은 형식(.tfvars or .tfvars.json)으로 Variable을 정의하여 사용할 수 있다. 파일명 지정 없이도 tfvars 파일을 인식한다.

# - terraform.tfvars
# - terraform.tfvars.json
# - *.auto.tfvars
# - *.auto.tfvars.json

# 테라폼에서 자동으로 로드되는 파일이며, 변수 값을 설정할 수 있습니다.
# terraform apply -var="foo=value" -var="bar=value" 와 같은 내용을 아래와 같이 작성하여 사용
# foo = "value"
# bar = "value"
################################################
# config_file = "./config.yaml"