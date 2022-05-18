# variable declaration for ports to be configured with our EC2 instance
variable "ingressrules" {
  type = list(number)
  default = [ 80, 443 ]
}

variable "egressrules" {
  type = list(number)
  default = var.ingressrules
}

output "sg_name" {
  value = aws_security_group.webserver_sg.name
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