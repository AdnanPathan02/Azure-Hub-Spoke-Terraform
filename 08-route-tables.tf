resource "azurerm_route_table" "spoke1" {
  name                = "RT-Spoke1"
  location            = azurerm_virtual_network.spoke1.location
  resource_group_name = azurerm_resource_group.rg.name

  bgp_route_propagation_enabled = false

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}

resource "azurerm_route_table" "spoke2" {
  name                = "RT-Spoke2"
  location            = azurerm_virtual_network.spoke2.location
  resource_group_name = azurerm_resource_group.rg.name

  bgp_route_propagation_enabled = false

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}
resource "azurerm_route" "spoke1_default" {
  name                = "Default-Route-To-Azure-Firewall"
  resource_group_name = azurerm_resource_group.rg.name
  route_table_name    = azurerm_route_table.spoke1.name

  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.main.ip_configuration[0].private_ip_address
}

resource "azurerm_route" "spoke2_default" {
  name                = "Default-Route-To-Azure-Firewall"
  resource_group_name = azurerm_resource_group.rg.name
  route_table_name    = azurerm_route_table.spoke2.name

  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.main.ip_configuration[0].private_ip_address
}
resource "azurerm_subnet_route_table_association" "spoke1" {
  subnet_id      = azurerm_subnet.spoke1_workload.id
  route_table_id = azurerm_route_table.spoke1.id
}

resource "azurerm_subnet_route_table_association" "spoke2" {
  subnet_id      = azurerm_subnet.spoke2_workload.id
  route_table_id = azurerm_route_table.spoke2.id
}