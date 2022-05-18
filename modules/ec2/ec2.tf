variable "ec2name" {
  type = string
}

resource "aws_instance" "ec2" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"

  tags = {
      Name = var.ec2name
  }
}

# To acces any attribute/value from anything we have created inside a module, we have to create as output;
# To access that output we would use module.moduleName.outputName (in this case, that happens in main.tf)
output "instance_id" {
  value = aws_instance.ec2.id
}