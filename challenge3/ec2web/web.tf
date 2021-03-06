variable "ec2web_name" {
  type = string
}

# EC2 instance num2
resource "aws_instance" "web" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  security_groups = [ module.sg.sg_name ]
  user_data = file("./web/server-script.sh")
}

output "pub_ip" {
  value = module.eip.web_public_ip
}

module "eip" {
  source = "../eip"
  instance_id = aws_instance.web.id
}

module "sg" {
    source = "../sg"
}