output "sg_node_a" {
  value     = module.sg_nodea.sgoutput
  sensitive = false
}

output "sg_node_b" {
  value     = module.sg_nodeb.sgoutput
  sensitive = false
}


output "sg_node_d" {
  value     = module.sg_noded.sgoutput
  sensitive = false
}
