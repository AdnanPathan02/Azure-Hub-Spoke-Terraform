resource "azurerm_public_ip" "firewall" {
  name                = var.firewall_public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}
resource "azurerm_firewall_policy" "main" {
  name                = var.firewall_policy_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku = var.firewall_sku_tier

  threat_intelligence_mode = "Alert"

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}
resource "azurerm_firewall" "main" {
  name                = var.firewall_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "AZFW_VNet"
  sku_tier = var.firewall_sku_tier

  firewall_policy_id = azurerm_firewall_policy.main.id

  threat_intel_mode = "Alert"

  ip_configuration {
    name                 = "Firewall-IP-Configuration"
    subnet_id            = azurerm_subnet.azure_firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}
resource "azurerm_firewall_policy_rule_collection_group" "main" {
  name               = "Default-Rule-Collection-Group"
  firewall_policy_id = azurerm_firewall_policy.main.id
  priority           = 100

  network_rule_collection {
    name     = "Allow-Spoke-Communication"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "Spoke1-To-Spoke2"
      protocols             = ["Any"]
      source_addresses      = ["10.1.1.0/24"]
      destination_addresses = ["10.2.1.0/24"]
      destination_ports     = ["*"]
    }

    rule {
      name                  = "Spoke2-To-Spoke1"
      protocols             = ["Any"]
      source_addresses      = ["10.2.1.0/24"]
      destination_addresses = ["10.1.1.0/24"]
      destination_ports     = ["*"]
    }
  }
  nat_rule_collection {
    name     = "DNAT-RDP-Rules"
    priority = 200
    action   = "Dnat"

    rule {
      name                = "RDP-To-VM1"
      protocols           = ["TCP"]
      source_addresses    = [var.admin_source_public_ip]
      destination_address = azurerm_public_ip.firewall.ip_address
      destination_ports   = ["8080"]
      translated_address  = azurerm_network_interface.vm1.private_ip_address
      translated_port     = "3389"
    }

    rule {
      name                = "RDP-To-VM2"
      protocols           = ["TCP"]
      source_addresses    = [var.admin_source_public_ip]
      destination_address = azurerm_public_ip.firewall.ip_address
      destination_ports   = ["8081"]
      translated_address  = azurerm_network_interface.vm2.private_ip_address
      translated_port     = "3389"
    }
  }
}