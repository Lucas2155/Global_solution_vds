resource "aws_route_table" "route-app" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name                             = "route_main_APP_${var.ENV}"
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

# route associations private

resource "aws_route_table_association" "vpc-app-2-c" {
  subnet_id      = aws_subnet.vpc-private-2.id
  route_table_id = aws_route_table.route-app.id
}