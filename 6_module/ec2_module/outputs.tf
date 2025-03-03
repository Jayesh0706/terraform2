output "instance_id"{
    value = aws_instance.my_instance.id
}

output "public-ip"{
    value = aws_instance.my_instance.public_ip
}