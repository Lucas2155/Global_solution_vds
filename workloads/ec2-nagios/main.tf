data "aws_vpc" "vpc10" {
  filter {
    name = "tag:Name"
    values = ["vpc10"]
  }
}
data "aws_subnet_ids" "vpc10" {
  vpc_id = data.aws_vpc.vpc10.id
  filter {
    name = "tag:Name"
    values = ["sn_vpc_*"]
  }
}

data "aws_vpc" "vpc20" {
  filter {
    name = "tag:Name"
    values = ["vpc20"]
  }
}

data "aws_subnet_ids" "vpc20" {
  vpc_id = data.aws_vpc.vpc20.id
  filter {
    name = "tag:Name"
    values = ["sn_vpc_*"]
  }
}

module "sg_nagios" {
  source             = "../../engine/sg/"
  name_prefix        = "sg_vpc_10_public"
  env                = "sg_vpc_10_public"
  app                = "sg_vpc_10_public"
  modalidade         = "sg_vpc_10_public"
  projeto            = "sg_vpc_10_public"
  clustrer_eks       = "sg_vpc_10_public"
  vpc_id             = data.aws_vpc.vpc10.id
  services_ports     = ["22","80","3389"]
  protocol           = "tcp"
  list_ips = [data.aws_vpc.vpc10.cidr_block,"20.0.0.0/16","0.0.0.0/0"]
}


module "nagios" {
  source             = "../../engine/ec2-nagios/"
  ami                = "ami-0aeeebd8d2ab47354"
  type_instance      = var.type_instance
  ip_public          = true
  key_ssh_name       = var.key_ssh_name
  type_volume        = var.type_volume
  size_volume        = var.size_volume
  del_on_termination = var.del_on_termination
  private_ip         = "10.0.1.45" 
  vpc_security_group_ids = [module.sg_nagios.sgoutput]
  subnet_id          = tolist(data.aws_subnet_ids.vpc10.ids)[0]
  tag                = "Nagios"
}

