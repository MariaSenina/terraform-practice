provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

# Steps for deploying:
# 1. Run ```terraform init``` -> pulls the plugin.
# 2. Run ```terraform plan``` -> checks the state (what has already been created? what is left to create?).
# 3. Run ```terraform apply``` -> check that this is what we want to go ahead and deply -> type 'yes', if yo're satisfied.

# Deleting a resource:
# Run ```terraform destroy``` -> automatically runs ```run``` command -> type 'yes' if you want to go ahead and delete the resource.