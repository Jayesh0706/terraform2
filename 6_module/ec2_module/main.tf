provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "my_instance"{
    ami = var.ami_id
    instance_type = var.type
    tags = {
      name = var.tag
    }

    vpc_security_group_ids = [ var.security_group_id ]

}

