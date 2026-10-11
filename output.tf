output "vnet_name" {
  value = module.network.vnet_name
}

output "snet_id" {
  value = module.network.snet_id
}

output "snet_name" {
  value = module.network.snet_name
}

output "nsg_id" {
  value = module.security.nsg_id
}

output "nsg_name" {
  value = module.security.nsg_name
}

output "vm_names" {
  value = module.compute.vm_names
}

output "private_ips" {
  value = module.compute.private_ips
}

output "lb_name" {
  value = module.lb.lb_name
}

output "pip" {
  value = module.lb.pip
}