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