# Azure subscription

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

# Resource Group

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "RG-Hub-Spoke-Terraform"
}

variable "location" {
  description = "Primary Azure region for Resource Group, Hub and Spoke1"
  type        = string
  default     = "Central India"
}

variable "spoke2_location" {
  description = "Azure region for Spoke2"
  type        = string
  default     = "East US"
}

# Hub VNet

variable "hub_vnet_address_space" {
  description = "Hub VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "firewall_subnet_prefix" {
  description = "Azure Firewall subnet address prefix"
  type        = list(string)
  default     = ["10.0.0.0/26"]
}

# Spoke1 VNet

variable "spoke1_vnet_address_space" {
  description = "Spoke1 VNet address space"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "spoke1_subnet_prefix" {
  description = "Spoke1 workload subnet address prefix"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

# Spoke2 VNet

variable "spoke2_vnet_address_space" {
  description = "Spoke2 VNet address space"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "spoke2_subnet_prefix" {
  description = "Spoke2 workload subnet address prefix"
  type        = list(string)
  default     = ["10.2.1.0/24"]
}

# Azure Firewall

variable "firewall_name" {
  description = "Azure Firewall name"
  type        = string
  default     = "FW-Hub"
}

variable "firewall_policy_name" {
  description = "Azure Firewall Policy name"
  type        = string
  default     = "FW-Policy-Hub"
}

variable "firewall_public_ip_name" {
  description = "Azure Firewall Public IP name"
  type        = string
  default     = "PIP-Azure-Firewall"
}

variable "firewall_sku_tier" {
  description = "Azure Firewall SKU tier"
  type        = string
  default     = "Standard"
}

# Network Security Groups

variable "admin_source_public_ip" {
  description = "Public IPv4 address allowed for RDP through Azure Firewall"
  type        = string
}

variable "spoke1_nsg_name" {
  description = "Spoke1 Network Security Group name"
  type        = string
  default     = "NSG-Spoke1-Workload"
}

variable "spoke2_nsg_name" {
  description = "Spoke2 Network Security Group name"
  type        = string
  default     = "NSG-Spoke2-Workload"
}

# Virtual Machines

variable "admin_username" {
  description = "Administrator username for Windows VMs"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Administrator password for Windows VMs"
  type        = string
  sensitive   = true
}
variable "vm1_size" {
  description = "VM size for VM1 in Central India"
  type        = string
  default     = "Standard_D2ls_v5"
}
variable "vm2_size" {
  description = "VM size for VM2 in East US"
  type        = string
  default     = "Standard_DC2ds_v3"
}
variable "vm1_name" {
  description = "Name of Spoke1 Windows VM"
  type        = string
  default     = "VM-Spoke1"
}
variable "vm2_name" {
  description = "Name of Spoke2 Windows VM"
  type        = string
  default     = "VM-Spoke2"
}

variable "vm1_private_ip" {
  description = "Static private IP address for VM1"
  type        = string
  default     = "10.1.1.4"
}

variable "vm2_private_ip" {
  description = "Static private IP address for VM2"
  type        = string
  default     = "10.2.1.4"
}