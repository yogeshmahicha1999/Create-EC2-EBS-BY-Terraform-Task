output "public_ip" {
        value = aws_instance.os1.public_ip
}


output "os-status" {
        value = aws_instance.os1.instance_state
}

output "OS_AZ_name" {
        value = aws_instance.os1.availability_zone
}
    
