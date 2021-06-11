output "vpca" {
   value = module.vpca.vpc
}

output "vpcb" {
    value = module.vpcb.vpc
}

output "cidra" {
  value = module.vpca.vpc_cidr_block
  
}

output "cidrb" {
  value = module.vpcb.vpc_cidr_block
  
}