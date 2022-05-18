variable "instance_id" {
  type = string

}

# eip attached to the second EC2 instance
resource "aws_eip" "webserver_eip" {
  instance = var.instance_id
}

output "web_public_ip" {
  value = aws_eip.webserver_eip.public_ip
}