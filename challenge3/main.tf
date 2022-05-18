provider "aws" {
  region = "us-east-1"
}

# module for ec2 num1
module "db_ec2instance" {
  source = "./ec2db"
  ec2db_name = "DB Server"
}

output "db_module_pip" {
  value = module.db_ec2instance.db_private_ip
}

# module for ec2 num2
module "web_ec2instance" {
  source = "./ec2web"
  ec2db_name = "Web Server"
}