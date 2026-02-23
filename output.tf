output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "vm_private_ips" {
  value       = azurerm_network_interface.nic[*].private_ip_address
  description = "Les IPs privées des deux VMs"
}

output "load_balancer_public_ip" {
  value       = azurerm_public_ip.lb_pip.ip_address
  description = "L'IP publique du Load Balancer pour accéder au service web"
}