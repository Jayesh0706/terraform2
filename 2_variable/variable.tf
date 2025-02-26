variable "ami_id_ubuntu"{
    description = "This is AMI id for ubuntu machine"
    type = string
    default = "ami-00bb6a80f01f03502"
}

variable "location"{
    description = "For Mumbai location"
    type = string
    default = "ap-south-1"
}

variable "count_of_machine"{
    description = "No of machine to use"
    type = number
    default = 2
}

variable "machine_type"{
    description = "Machine type of free-tier"
    type = string
    default = "t2.micro"
}

variable "tag_of_env" {
    description = "Tag for web tier machines"
    type = string
    default = "Dev_env"
}