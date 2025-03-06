resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "mysubnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Subnet-1"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "mysubnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"

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