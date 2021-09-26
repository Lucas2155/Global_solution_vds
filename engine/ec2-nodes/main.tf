resource "aws_instance" "ec2-main" {
  ami                         = var.ami
  instance_type               = var.type_instance
  associate_public_ip_address = var.ip_public != "" ? var.ip_public : true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  private_ip = var.private_ip
  key_name = var.key_ssh_name
  root_block_device {
    volume_type           = var.type_volume != "" ? var.type_volume : "gp2"
    volume_size           = var.size_volume != "" ? var.size_volume : 8
    delete_on_termination = var.del_on_termination != "" ? var.del_on_termination : true
  }

  #provisioner "file" {
    #source      = "/home/raphael_santos/Documentos/iac/vpc-network/ec2-egine-worker/conf/install_node.sh"
    #destination = "/tmp/install_node.sh"
  #}
  #connection {
      #type        = "ssh"
      #user        = "ec2-user"
      #private_key = file("~/.ssh/ansible-lab-rapha.pem")
     #host        = self.public_ip
    #}
  #provisioner "remote-exec" {
    #inline = [
      #"sudo chmod 755 /tmp/install_node.sh",
      #"sudo /tmp/install_node.sh"
    #]
   
    #connection {
      #type        = "ssh"
      #user        = "ec2-user"
      #private_key = file("~/.ssh/ansible-lab-rapha.pem")
     #host        = self.public_ip
    #}
  #}
  tags = {
    Name = var.tag
  }
}