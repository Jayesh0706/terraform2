


resource "aws_instance" "my_instances" {
  ami = var.ami_id_ubuntu
  instance_type = var.machine_type
  count = var.tag_of_env == "Dev_env" ? var.count_of_machine : 2
  tags = {
    Name = var.tag_of_env
  }
}

resource "aws_security_group" "my-sg" {
  name = "my-sg-env"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}

output "ip" {
  value = [for instance in aws_instance.my_instances : instance.public_ip]
}