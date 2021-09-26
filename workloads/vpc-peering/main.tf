data "aws_vpc" "vpc10" {
  filter {
    name = "tag:Name"
    values = ["vpc10"]
  }
}

data "aws_route_tables" "vpc10" {
  vpc_id = data.aws_vpc.vpc10.id

}

data "aws_subnet_ids" "vpc10" {
  vpc_id = data.aws_vpc.vpc10.id
  filter {
    name = "tag:Name"
    values = ["sn_vpc_*"]
  }
}

data "aws_subnet" "vpc10" {
  for_each = data.aws_subnet_ids.vpc10.ids
  id       = each.value

}

data "aws_vpc" "vpc20" {
  filter {
    name = "tag:Name"
    values = ["vpc20"]
  }
}

data "aws_route_tables" "vpc20" {
  vpc_id = data.aws_vpc.vpc20.id

}

data "aws_subnet_ids" "vpc20" {
  vpc_id = data.aws_vpc.vpc20.id
  filter {
    name = "tag:Name"
    values = ["sn_vpc_*"]
  }
}

data "aws_subnet" "vpc20" {
  for_each = data.aws_subnet_ids.vpc20.ids
  id       = each.value
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = data.aws_vpc.vpc10.id
  vpc_id        = data.aws_vpc.vpc20.id
  auto_accept   = true

  tags = {
    Name = "Perring"
  }
}

resource "aws_route" "rotavpca" {
  for_each = data.aws_route_tables.vpc10.ids
  route_table_id            = each.value
  destination_cidr_block    = data.aws_vpc.vpc20.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
}   

resource "aws_route" "rotavpcb" {
  for_each = data.aws_route_tables.vpc20.ids
  route_table_id            = each.value
  destination_cidr_block    = data.aws_vpc.vpc10.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
}