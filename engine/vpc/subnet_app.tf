
resource "aws_subnet" "vpc-private-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.CIDR_cloudit_APP_C
  map_public_ip_on_launch = false
  availability_zone       = var.cloudit_APP_C

  tags = {
    Name                                                   = "sn_vpc_${var.nuvpc}_private"
    Terraform                                              = "true"
    Ambiente                                               = "${var.ENV}"
    APP                                                    = "cloudit"
    Projeto                                                = "cloudit"
    "kubernetes.io/cluster/${var.cluster-name}-${var.ENV}" = "shared"

  }
}