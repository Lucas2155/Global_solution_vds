
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
    values = ["cloudit_*"]
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
    values = ["cloudit_*"]
  }
}



module "sg_nodea" {
  source             = "../../engine/sg/"
  name_prefix        = "sg_vpc_10_private"
  env                = "sg_vpc_10_private"
  app                = "sg_vpc_10_private"
  modalidade         = "sg_vpc_10_private"
  projeto            = "sg_vpc_10_private"
  clustrer_eks       = "sg_vpc_10_private"
  vpc_id             = data.aws_vpc.vpc10.id
  services_ports     = ["0","0"]
  protocol          = "-1"
  list_ips = [data.aws_vpc.vpc10.cidr_block,"20.0.0.0/16"]
}


module "nodea" {
  source             = "../../engine/ec2-nodes/"
  ami                = "ami-0e7e3b583517298ac"
  type_instance      = var.type_instance
  ip_public          = false
  key_ssh_name       = var.key_ssh_name
  private_ip         = "10.0.1.50"
  type_volume        = var.type_volume
  size_volume        = var.size_volume
  del_on_termination = var.del_on_termination
  vpc_security_group_ids = [module.sg_nodea.sgoutput]
  subnet_id          = tolist(data.aws_subnet_ids.vpc10.ids)[0]
  tag                = "node_a"
}

module "nodec" {
  source             = "../../engine/ec2-nodes/"
  ami                = "ami-0e7e3b583517298ac"
  type_instance      = var.type_instance
  ip_public          = false
  key_ssh_name       = var.key_ssh_name
  private_ip         = "10.0.2.52"
  type_volume        = var.type_volume
  size_volume        = var.size_volume
  del_on_termination = var.del_on_termination
  vpc_security_group_ids = [module.sg_nodea.sgoutput]
  subnet_id          = tolist(data.aws_subnet_ids.vpc10.ids)[1]
  tag                = "node_c"
}



module "sg_nodeb" {
  source             = "../../engine/sg/"
  name_prefix        = "sg_vpc_20_public"
  env                = "sg_vpc_20_public"
  app                = "sg_vpc_20_public"
  modalidade         = "sg_vpc_20_public"
  projeto            = "sg_vpc_20_public"
  clustrer_eks       = "sg_vpc_20_public"
  vpc_id             = data.aws_vpc.vpc20.id
  services_ports     = ["0","0"]
  protocol          = "-1"
  list_ips = [data.aws_vpc.vpc20.cidr_block,"10.0.1.0/24","10.0.2.0/24"]
}

module "nodeb" {
  source             = "../../engine/ec2-nodes/"
  ami                = "ami-0e7e3b583517298ac"
  type_instance      = var.type_instance
  ip_public          = false
  key_ssh_name       = var.key_ssh_name
  private_ip         = "20.0.1.50"
  type_volume        = var.type_volume
  size_volume        = var.size_volume
  del_on_termination = var.del_on_termination
  vpc_security_group_ids = [module.sg_nodeb.sgoutput]
  subnet_id          = tolist(data.aws_subnet_ids.vpc20.ids)[0]
  tag                = "node_b"
}

module "sg_noded" {
  source             = "../../engine/sg/"
  name_prefix        = "sg_vpc_20_private"
  env                = "sg_vpc_20_private"
  app                = "sg_vpc_20_private"
  modalidade         = "sg_vpc_20_private"
  projeto            = "sg_vpc_20_private"
  clustrer_eks       = "sg_vpc_20_private"
  vpc_id             = data.aws_vpc.vpc20.id
  protocol          = "-1"
  services_ports     = ["0","0"]
  list_ips = [data.aws_vpc.vpc20.cidr_block,"10.0.0.0/16"]
}


module "noded" {
  source             = "../../engine/ec2-nodes/"
  ami                = "ami-0e7e3b583517298ac"
  type_instance      = var.type_instance
  ip_public          = false
  key_ssh_name       = var.key_ssh_name
  private_ip         = "20.0.2.52"
  type_volume        = var.type_volume
  size_volume        = var.size_volume
  del_on_termination = var.del_on_termination
  vpc_security_group_ids = [module.sg_noded.sgoutput]
  subnet_id          = tolist(data.aws_subnet_ids.vpc20.ids)[1]
  tag                = "node_d"
}