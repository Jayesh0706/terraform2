
variable "vpc_cidr_block"{
    description = "CIDR block for VPC "
    type = string
}

variable "subnet_cidr_block"{
    description = "CIDR block for Subnet "
    type = string
}

variable "zone" {
  description = "Zone of subnet"
  type = string
}