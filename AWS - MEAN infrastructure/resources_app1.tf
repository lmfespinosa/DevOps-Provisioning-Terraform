resource "aws_key_pair" "key_app1" {
  key_name   = "key-app1"
  public_key = file(var.key_pair_path["public_key_path"])
}


resource "aws_instance" "app1" {
  ami           = data.aws_ami.ubuntu_app1.id
  instance_type = "t2.micro"
  key_name   = aws_key_pair.key_app1.key_name 
  associate_public_ip_address = "true"

  subnet_id = aws_subnet.public_sbn.id
  security_groups = ["${aws_security_group.FrontEnd.id}"]
  availability_zone = var.aws_availability_zone
  
  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "App1"
  }

 
  connection {
      host =  self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      agent       = true
      private_key = file(var.key_pair_path["private_key_path"])
    }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ubuntu/files",
      "mkdir /home/ubuntu/web",
    ]
  }

  provisioner "file" {
    content      = data.template_file.web.rendered
    destination = "/home/ubuntu/web/web.js"
  }

  provisioner "file" {
    content     = data.template_file.nginx.rendered
    destination = "/home/ubuntu/files/nginx.conf"
  }

  provisioner "remote-exec" {
    script = "scripts/config_app1.sh"
    
  }

  #depends_on = [aws_nat_gateway.public_ngw]
}


resource "null_resource" "reboo_instance" {

  provisioner "local-exec" {
    
    on_failure  = fail
    #interpreter = ["/usr/bin/env bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[31m Warning! Restarting instance having id ${aws_instance.app1.id}.................. \x1B[0m"
        # aws ec2 reboot-instances --instance-ids ${aws_instance.app1.id}
        # To stop instance
        aws ec2 reboot-instances --instance-ids ${aws_instance.app1.id} --profile profile
        echo "***************************************Rebooted****************************************************"
     EOT
  }
#   this setting will trigger script every time,change it something needed
  triggers = {
    always_run = "${timestamp()}"
  }
  

}

#Crear perfil para aws command en local
#$ aws configure --profile produser
#AWS Access Key ID [None]: AKIAI44QH8DHBEXAMPLE
#AWS Secret Access Key [None]: je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
#Default region name [None]: us-east-1
#Default output format [None]: text