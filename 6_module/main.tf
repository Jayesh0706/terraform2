provider "aws"{
    region = "ap-south-1"
}


module "security_group"{
    source = "./security_group"
}

module "ec2_module"{
    source = "./ec2_module"
    ami_id = "ami-00bb6a80f01f03502"
    type = "t2.micro"
    tag = "Webserver"
    security_group_id = module.security_group.sg-id

}