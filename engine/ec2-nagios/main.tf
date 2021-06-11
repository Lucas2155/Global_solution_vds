resource "aws_instance" "ec2-main" {
  ami                         = var.ami
  instance_type               = var.type_instance
  associate_public_ip_address = var.ip_public != "" ? var.ip_public : true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name = var.key_ssh_name
  private_ip = var.private_ip
  root_block_device {
    volume_type           = var.type_volume != "" ? var.type_volume : "gp2"
    volume_size           = var.size_volume != "" ? var.size_volume : 8
    delete_on_termination = var.del_on_termination != "" ? var.del_on_termination : true
  }
  provisioner "file" {
    source      = "$PWD/conf/conf.zip"
    destination = "/tmp/conf.zip"
  }
  connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/ec2-nagios.pem")
     host        = self.public_ip
    }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y unzip",
      "unzip /tmp/conf.zip",
      "sudo chmod 755 /home/ec2-user/conf/install.sh",
      "sudo /home/ec2-user/conf/install.sh",
      "sudo rm -rf /usr/local/nagios/etc/objects/localhost.cfg",
      "sudo mv /home/ec2-user/conf/localhost.cfg /usr/local/nagios/etc/objects/localhost.cfg",
      "sudo service nagios reload"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/ec2-nagios.pem")
     host        = self.public_ip
    }
  }
   tags = {
    Name = var.tag
  }
}