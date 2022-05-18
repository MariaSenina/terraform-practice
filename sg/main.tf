provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name] # <- link the security group from below to our EC2 instance
}

# NOTE: aws_security_groups are stateful
#       this means that as long as the traffic is allowed to come in, it is also allowed out through the same port.
resource "aws_security_group" "webtraffic" {
  name = "Allows HTTPS"

# allow the traffic in
  ingress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"] # <- allow to all traffic
  }

# allows the traffic out
  egress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

# NOTE: since aws_security_groups are stateful, we don't technically need to define ingress and egress. However, it adds clarity to the code.
}