variable "ingress_ports"{
    type = list(number)
    default = [ 80, 22 ]
}

variable egress-ports{
    type = list(number)
    default = [ 0 ]
}


resource aws_security_group "webserver-sg"{
    name = "web-sg"
    vpc_id = aws_vpc.web-vpc.id

    dynamic "ingress"{
        for_each = var.ingress_ports

        content{
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "egress"{
        for_each = var.egress-ports

        content{
        from_port   = egress.value
        to_port     = egress.value
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }


}