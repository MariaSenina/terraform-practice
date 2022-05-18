provider "aws" {
  region = "us-east-1"
}

module "ec2module" {
  source = "./ec2"
  ec2name = "Name From Module" # <- assign a value to the variable we declared in the ec2 module
}

# NOTE: run ```terraform init``` every time you make a change to the modules, so Terraform is aware of which modules are in use.

output "module_output" {
  value = module.ec2module.instance_id
}