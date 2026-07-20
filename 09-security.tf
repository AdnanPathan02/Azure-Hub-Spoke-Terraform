resource "azurerm_network_security_group" "spoke1" {
  name                = var.spoke1_nsg_name
  location            = azurerm_virtual_network.spoke1.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Project     = "Azure Hub-Spoke"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_network_security_group" "spoke2" {
  name                = var.spoke2_nsg_name
  location            = azurerm_virtual_network.spoke2.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Project     = "Azure Hub-Spoke"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}
resource "azurerm_network_security_rule" "spoke1_allow_rdp" {
  name                        = "Allow-RDP-From-Azure-Firewall"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = azurerm_firewall.main.ip_configuration[0].private_ip_address
  destination_address_prefix  = "10.0.0.4"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.spoke1.name
}

resource "azurerm_network_security_rule" "spoke1_allow_spoke2" {
  name                        = "Allow-Spoke2-To-Spoke1"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.2.1.0/24"
  destination_address_prefix  = "10.1.1.0/24"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.spoke1.name
}
resource "azurerm_network_security_rule" "spoke2_allow_rdp" {
  name                        = "Allow-RDP-To-VM2"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = azurerm_firewall.main.ip_configuration[0].private_ip_address
  destination_address_prefix  = "10.2.1.4"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.spoke2.name
}

resource "azurerm_network_security_rule" "spoke2_allow_spoke1" {
  name                        = "Allow-RDP-From-Azure-Firewall"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_firewall.main.ip_configuration[0].private_ip_address
  destination_address_prefix  = "10.2.1.4"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.spoke2.name
}
resource "azurerm_subnet_network_security_group_association" "spoke1" {
  subnet_id                 = azurerm_subnet.spoke1_workload.id
  network_security_group_id = azurerm_network_security_group.spoke1.id
}

resource "azurerm_subnet_network_security_group_association" "spoke2" {
  subnet_id                 = azurerm_subnet.spoke2_workload.id
  network_security_group_id = azurerm_network_security_group.spoke2.id
}