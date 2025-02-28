variable "ami_id"{
    description = "AMI ID for EC2 instance"
    type = string
}

variable type{
    description = "Type of ec2 instance"
    type = string
}

variable tag{
    description = "tag of EC2"
    type = string    
}

variable "security_group_id" {
    description = " Value of security group ID created in Security Group Module"
    type = string
}