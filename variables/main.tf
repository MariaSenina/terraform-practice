provider "aws" {
  region = "us-east-1"
}

variable "vpcname" {
  type = string
  default = "myvpc"
}

# analogous to integer 
variable "sshport" {
  type = number
  default = 22
}

variable "enabled" {
# NOTE: there is no 'type' here
  default = true
}

variable "myList" {
  type = list(string)
  default = [ "Value1", "Value2" ]
}

variable "mymap" {
  type = map
  default = {
      Key1 = "Value1"
      Key2 = "Value2"
  }
}

# Input variables allow the user to manually set a variable when they run ```terraform plan``` command
variable "inputname" {
  type = string
  description = "Set the name of the VPC"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
  }
}

# With outputs, we can get details about the resources we've created.
# NOTE: in this case, we will only get the output once ```terraform apply``` command is run. 
#       Remember, a vpc is only assigned an id after it has been created in aws.
output "vpcid" {
# resourceName.name.attributeToAccess
  value = aws_vpc.myvpc.id
}

# Tuples
# A tuple is basically a list that can support multiple data types.
variable "mytuple" {
  type = tuple(string, number, string)
  default = ["cat", 1, "dog"]
}

variable "myobject" {
  type = object({name = string, port = list(number)})
  default = {
    name = "Test"
    port = [ 22, 25, 80 ]
  }
}