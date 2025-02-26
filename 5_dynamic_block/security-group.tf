variable "ingress_ports"{
    type = list(number)
    default = [ 443, 22, 80, 8080 ]
}

variable "egress_ports"{
    type = list(number)
    default = [ 7000, 9000 ]
}



resource "aws_security_group" "allow_tls"{
    name = "Dev-sg"

    dynamic "ingress"{
     for_each = var.ingress_ports
     #or
     #iterator = ports

    content {
        from_port = ingress.value #or ingress.ports if you use iterator
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    }


    dynamic "egress"{
        for_each = var.egress_ports
        iterator = ports

        content{
            from_port = ports.value #or ingress.ports if you use iterator
        to_port = ports.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        } 
    }
}

