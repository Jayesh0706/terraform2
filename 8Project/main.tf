resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "mysubnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Subnet-1"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "mysubnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "Subnet-2"
  }
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "RTa1" {
  subnet_id      = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "RTa2" {
  subnet_id      = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "mysg" {
  name = "web-sg"
  description = "Allow TLS Inbound Traffic"
  vpc_id = aws_vpc.myvpc.id
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress  {
    from_port = 0
    to_port = 0 
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_s3_bucket" "MyBucket" {
  bucket = "jayesh362025"  #globally-unique

  tags = {
    Name        = "jayesh07062001"
    Environment = "Dev"
  }
}

resource "aws_instance" "webserver1" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id] 
  subnet_id = aws_subnet.mysubnet1.id
  user_data = base64encode(file("userdata1.sh"))
}

resource "aws_instance" "webserver2" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id = aws_subnet.mysubnet2.id
  user_data = base64encode(file("userdata2.sh"))
}


resource "aws_lb" "my-lb" {
  name = "MyAlb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.mysg.id ]
  subnets = [ aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id ]
  tags = {
    Name = "Web"
  }
}

resource "aws_lb_target_group" "my-tg" {
  name = "myTG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "Attach1" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id = aws_instance.webserver1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "Attach2" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id = aws_instance.webserver2.id
  port = 80
}

resource "aws_lb_listener" "myListner" {
  
  load_balancer_arn = aws_lb.my-lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my-tg.arn
    type = "forward"
  }
}

output "loadbalancerdns" {
  value = aws_lb.my-lb.dns_name
}