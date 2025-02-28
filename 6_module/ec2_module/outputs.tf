output "instance_id"{
    value = aws_instance.my_instance.id
}

output "Ip"{
    value = aws_instance.my_instance.public_ip
}