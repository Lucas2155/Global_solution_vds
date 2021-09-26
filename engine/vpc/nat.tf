# nat gw
resource "aws_eip" "main-nat" {
  vpc = true
  tags = {
    Name                             = "var.nuvpc"
    Terraform                        = "true"
    Ambiente                         = var.ENV
    APP                              = "main"
    Projeto                          = "main"
    
    "kubernetes.io/cluster/teste" = "shared"
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.main-nat.id
  subnet_id     = aws_subnet.vpc-public-0.id
  depends_on    = ["aws_internet_gateway.vpc-gw"]
  tags = {
    Name                             = "ngw_${var.nuvpc}"
    Terraform                        = "true"
    Ambiente                         = var.ENV
    APP                              = "main"
    Projeto                          = "main"
    
    "kubernetes.io/cluster/teste" = "shared"
  }

  lifecycle {
    create_before_destroy = true
  }
}

