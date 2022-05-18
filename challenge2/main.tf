provider "aws" {
  region = "us-east-1"
}

# variable declaration for ports to be configured with our EC2 instance
variable "ingressrules" {
  type = list(number)
  default = [ 80, 443 ]
}

variable "egressrules" {
  type = list(number)
  default = var.ingressrules
}

# EC2 instance num1
resource "aws_instance" "db" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"

  tags {
      Name = "DB Server"
  }
}

output "private_ip" {
  value = aws_instance.db.private_ip
}

# EC2 instance num2
resource "aws_instance" "web" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.webserver_sg.name ]
  user_data = file("server-script.sh")

  tags = {
      Name = "Web Server"
  }
}

# eip attached to the second EC2 instance
resource "aws_eip" "webserver_eip" {
  instance = aws_instance.web.id
}

# security group definition for the second EC2 instance
resource "aws_security_group" "webserver_sg" {
  name = "Allow Web Traffic"

  ingress {
      iterator = port
      for_each = var.ingressrules
      content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = [ "0.0.0.0/0" ]
      }
  }

  egress {
      iterator = port
      for_each = var.egressrules
      content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = [ "0.0.0.0/0" ]
      }
  }
}

# Instructions to invoke a script on a remote resource after it has been created
connection {
    type = "ssh"
    user = "root"
    password = ""
    host = self.public_ip
}