resource "aws_key_pair" "key_app2" {
  key_name   = "key-app2"
  public_key = file(var.key_pair_path["public_key_path"])
}


resource "aws_instance" "app2" {
  ami           = data.aws_ami.ubuntu_app2.id
  instance_type = "t2.micro"
  key_name   = aws_key_pair.key_app2.key_name 
  #associate_public_ip_address = "true"

  subnet_id = aws_subnet.private_sbn.id
  security_groups = ["${aws_security_group.Database.id}"]
  availability_zone = var.aws_availability_zone
  private_ip = var.IpApp2

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "App2"
  }

  #provisioner "file" {
  #  source      = "files/templates/mongodb/mongod.service"
  #  destination = "/home/ubuntu/files/mongod.service"
  #}
  #provisioner "file" {
  #  source      = "files/templates/mongodb/mongod.conf"
  #  destination = "/home/ubuntu/files/mongod.conf"
  #}

 user_data = <<HEREDOC
  #!/usr/bin/env bash
  sudo apt-get update -y

  echo "MongoDB Install"
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 68818C72E52529D4
  sudo echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
  sudo apt-get update -y
  sudo apt-get install -y mongodb-org
  sudo systemctl start mongod
  sudo systemctl enable mongod
  mongo
use admin
 
echo "Create admin user"
db.createUser({user:"admin", pwd:"admin123", roles:[{role:"root", db:"admin"}]})
exit

echo "copy file"
cp /home/ubuntu/files/mongod.service /lib/systemd/system/mongod.service

sudo systemctl daemon-reload

sudo service mongod restart
sudo ufw allow ssh
sudo ufw enable
sudo ufw allow 27017

sudo service mongod restart
  HEREDOC

  #connection {
  #    bastion_host = aws_instance.app1.public_ip
  #    host =  aws_instance.app2.private_ip
  #    type        = "ssh"
  #    user        = "ubuntu"
  #    agent       = true
  #    private_key = file(var.key_pair_path["private_key_path"])
  #}

  #provisioner "remote-exec" {
  #  script = "scripts/config_app2.sh"
    
  #}

  #provisioner "remote-exec" {
  #  inline = ["echo 'CONNECTED to PRIVATE!'"]
  #}

  #depends_on = [aws_nat_gateway.public_ngw]
}