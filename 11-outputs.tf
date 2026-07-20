output "hub_vnet_id" {
  description = "Hub VNet resource ID"
  value       = azurerm_virtual_network.hub.id
}

output "spoke1_vnet_id" {
  description = "Spoke1 VNet resource ID"
  value       = azurerm_virtual_network.spoke1.id
}

output "spoke2_vnet_id" {
  description = "Spoke2 VNet resource ID"
  value       = azurerm_virtual_network.spoke2.id
}
output "firewall_name" {
  description = "Azure Firewall name"
  value       = azurerm_firewall.main.name
}

output "firewall_private_ip" {
  description = "Azure Firewall private IP address"
  value       = azurerm_firewall.main.ip_configuration[0].private_ip_address
}

output "firewall_public_ip" {
  description = "Azure Firewall public IP address"
  value       = azurerm_public_ip.firewall.ip_address
}

output "firewall_policy_id" {
  description = "Azure Firewall Policy resource ID"
  value       = azurerm_firewall_policy.main.id
}
output "spoke1_route_table_id" {
  description = "Spoke1 Route Table resource ID"
  value       = azurerm_route_table.spoke1.id
}

output "spoke2_route_table_id" {
  description = "Spoke2 Route Table resource ID"
  value       = azurerm_route_table.spoke2.id
}
output "spoke1_nsg_id" {
  description = "Spoke1 Network Security Group ID"
  value       = azurerm_network_security_group.spoke1.id
}

output "spoke2_nsg_id" {
  description = "Spoke2 Network Security Group ID"
  value       = azurerm_network_security_group.spoke2.id
}
output "vm1_name" {
  description = "VM1 name"
  value       = azurerm_windows_virtual_machine.vm1.name
}

output "vm1_private_ip" {
  description = "VM1 private IP address"
  value       = azurerm_network_interface.vm1.private_ip_address
}

output "vm2_name" {
  description = "VM2 name"
  value       = azurerm_windows_virtual_machine.vm2.name
}

output "vm2_private_ip" {
  description = "VM2 private IP address"
  value       = azurerm_network_interface.vm2.private_ip_address
}