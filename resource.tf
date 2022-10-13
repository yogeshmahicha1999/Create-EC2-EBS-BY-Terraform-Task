#Block name " resource name and resource type"
resource "aws_instance" "os1" {

        ami = var.amiID
        instance_type = "t2.micro"
        key_name = "Terraform"
        vpc_security_group_ids = [ "sg-0dd3a8e19de252e2a" ]
        tags =  {
                        Name = var.osName
        }



        # SSH Connection
        connection {
                type = "ssh"
                user = "ec2-user"
                private_key = file("/home/softobiz-yogeshmahicha/Downloads/Terraform.pem")
                host = aws_instance.os1.public_ip
                }
        provisioner "remote-exec" {
                inline = [
                  "sudo yum install httpd -y",
                  "sudo touch /var/www/html/index.html",
                  "sudo systemctl enable httpd --now"
                  ]
                }


}


# add volume

resource "aws_ebs_volume" "myvol" {
        availability_zone = aws_instance.os1.availability_zone
        size                =  1
        tags = {
                Name = "mywebvol"
                }
        }

#attach volume 

resource "aws_volume_attachment" "ebs_attach_ec2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.myvol.id
  instance_id = aws_instance.os1.id
}



