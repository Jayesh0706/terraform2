provider "aws"{
    region = "ap-south-1"
}


module "security_group"{
    source = "./security_group"
    sg-name = "Web-Server"
}

module "ec2_module"{
    source = "./ec2_module"
    ami_id = var.ami_id
    type = var.type
    tag = var.tag
    security_group_id = module.security_group.sg-id
}