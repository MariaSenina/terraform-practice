variable "ec2db_name" {
  type = string
}

# EC2 instance num1
resource "aws_instance" "db" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
}

output "db_private_ip" {
  value = aws_instance.db.private_ip
}