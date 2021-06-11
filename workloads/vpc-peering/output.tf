#output "subnets" {
#    value = [data.aws_vpc.vpc10.id,data.aws_vpc.vpc20.id, data.aws_subnet_ids.vpc10.ids, data.aws_subnet_ids.vpc20.ids ]
#}
output "subnets" {
    value = [data.aws_vpc.vpc10.id, 
             data.aws_subnet_ids.vpc10.ids, 
             #data.aws_subnet_ids.vpc10.*, 
             data.aws_vpc.vpc20.id, 
             data.aws_subnet_ids.vpc20.ids, 
             #data.aws_subnet_ids.vpc20.* 
            ]
}
output "subnet_cidr_blocks_20" {
  value = [for s in data.aws_subnet.vpc20 : s.cidr_block]
}

output "subnet_cidr_blocks_10" {
  value = [for s in data.aws_subnet.vpc10 : s.cidr_block]
}

output "route_table" {
  value = [data.aws_subnet_ids.vpc20.ids]
}
