output "ec2-id"{
    value = module.ec2_module.instance_id
}
output "public-ip"{
    value = module.ec2_module.public-ip
}