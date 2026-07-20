resource "azurerm_network_interface" "vm1" {
  name                = "NIC-${var.vm1_name}"
  location            = azurerm_virtual_network.spoke1.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke1_workload.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm1_private_ip
  }

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}
resource "azurerm_network_interface" "vm2" {
  name                = "NIC-${var.vm2_name}"
  location            = azurerm_virtual_network.spoke2.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke2_workload.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm2_private_ip
  }

  tags = {
    Project   = "Azure Hub-Spoke"
    ManagedBy = "Terraform"
  }
}
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = var.vm1_name
  computer_name       = "vmspoke1"
  location            = azurerm_virtual_network.spoke1.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.vm1_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.vm1.id
  ]

  provision_vm_agent        = true
  automatic_updates_enabled = true
  patch_mode                = "AutomaticByPlatform"

  os_disk {
    name                 = "OSDisk-${var.vm1_name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }

  tags = {
    Project     = "Azure Hub-Spoke"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}
resource "azurerm_windows_virtual_machine" "vm2" {
  name                = var.vm2_name
  computer_name       = "vmspoke2"
  location            = azurerm_virtual_network.spoke2.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.vm2_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.vm2.id
  ]

  provision_vm_agent        = true
  automatic_updates_enabled = true
  patch_mode                = "AutomaticByPlatform"

  os_disk {
    name                 = "OSDisk-${var.vm2_name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }

  tags = {
    Project     = "Azure Hub-Spoke"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}