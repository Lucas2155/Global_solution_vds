# Internet VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.CIDRVPC
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink
  tags = {
    Name                             = var.name_vpc
    Terraform                        = "true"
    Ambiente                         = var.ENV
    APP                              = "main"
    Projeto                          = "main"
    
    "kubernetes.io/cluster/teste" = "shared"
  }
}

# Internet GW
resource "aws_internet_gateway" "vpc-gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name                             = "igw_${var.nuvpc}"
    Terraform                        = "true"
    Ambiente                         = var.ENV
    APP                              = "main"
    Projeto                          = "main"
    
    "kubernetes.io/cluster/teste" = "shared"
  }
}

