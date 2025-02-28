provider "aws"{
    region = "ap-south-1"
}

resource "aws_key_pair" "mykey" {
  key_name = "tf-provisioner-key"
  public_key = file("/home/codespace/.ssh/id_rsa.pub")
}

resource "aws_vpc" "web-vpc" {
    cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "web-subnet-1" {
    vpc_id = aws_vpc.web-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.zone
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "web-igw" {
    vpc_id = aws_vpc.web-vpc.id
}

resource "aws_route_table" "web-RT" {
    vpc_id = aws_vpc.web-vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web-igw.id
  }
}

resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.web-subnet-1.id
    route_table_id = aws_route_table.web-RT.id
}

resource "aws_instance" "web-instance" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    key_name = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [ aws_security_group.webserver-sg.id ]
    subnet_id = aws_subnet.web-subnet-1.id

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/codespace/.ssh/id_rsa")
      host = self.public_ip
    }



    provisioner "remote-exec" {
      inline = [ 
        "echo 'Hello from remote instance '",
        "sleep 30",
        "sudo apt update -y",
        "sudo apt-get install nginx -y",
        "sudo systemctl start nginx",
        "sudo mkdir -p /usr/share/nginx/html",
        "sudo chown -R ubuntu:ubuntu /usr/share/nginx/html"
       ]
    }
    provisioner "file" {
      source = "web.html"
      destination = "/usr/share/nginx/html/"
    }
}


output "public_ip" {
  value = aws_instance.web-instance.public_ip
}