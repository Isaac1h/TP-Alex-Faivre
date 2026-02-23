output "resource_group_id" {
  value       = azurerm_resource_group.rg.id
  description = "L'ID du Resource Group"
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Le nom du VNET"
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "L'ID du Subnet"
}