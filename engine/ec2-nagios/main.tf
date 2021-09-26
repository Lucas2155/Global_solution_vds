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
      private_key = file("~/.ssh/ansible-lab-rapha.pem")
     host        = self.public_ip
    }

 user_data = <<-EOF
        #!/bin/bash
        # Nagios Core Install Instructions
        # https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html
        yum update -y
        setenforce 0
        cd /tmp
        yum install -y gcc glibc glibc-common make gettext automake autoconf wget openssl-devel net-snmp net-snmp-utils epel-release
        yum install -y perl-Net-SNMP
        yum install -y unzip httpd php gd gd-devel perl postfix
        cd /tmp
        wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.5.tar.gz
        tar xzf nagioscore.tar.gz
        cd /tmp/nagioscore-nagios-4.4.5/
        ./configure
        make all
        make install-groups-users
        usermod -a -G nagios apache
        make install
        make install-daemoninit
        systemctl enable httpd.service
        make install-commandmode
        make install-config
        make install-webconf
        iptables -I INPUT -p tcp --destination-port 80 -j ACCEPT
        ip6tables -I INPUT -p tcp --destination-port 80 -j ACCEPT
        htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin
        service httpd start
        service nagios start
        cd /tmp
        wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
        tar zxf nagios-plugins.tar.gz
        cd /tmp/nagios-plugins-release-2.2.1/
        ./tools/setup
        ./configure
        make
        make install
        service nagios restart
        echo done > /tmp/nagioscore.done
        rm -rf /usr/local/nagios/etc/objects/localhost.cfg
        mv /home/ec2-user/conf/localhost.cfg /usr/local/nagios/etc/objects/localhost.cfg
        service nagios reload
	      EOF
   tags = {
    Name = var.tag
  }
}