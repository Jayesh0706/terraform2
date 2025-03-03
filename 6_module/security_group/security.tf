variable "ingress_ports"{
    type = list(number)
    default = [ 80, 8080, 5000 ]
}

variable "egress_ports"{
    type = list(number)
    default = [ 9000, 25 ]
}

resource aws_security_group "my-sg"{
    name = var.sg-name

    dynamic ingress{
        for_each = var.ingress_ports
        iterator = ports

     content {
        from_port = ports.value #or ingress.ports if you use iterator
        to_port = ports.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    }

    dynamic egress{
        for_each = var.egress_ports
         content {
        from_port = egress.value #or ingress.ports if you use iterator
        to_port = egress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    }
}




