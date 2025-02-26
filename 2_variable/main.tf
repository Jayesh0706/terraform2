resource "aws_instance" "my_instances" {
  ami = var.ami_id_ubuntu
  instance_type = var.machine_type
  count = var.count_of_machine
  tags = {
    Name = var.tag_of_env
  }
}
