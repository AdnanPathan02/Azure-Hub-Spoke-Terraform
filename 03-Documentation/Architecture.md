# Architecture

This project implements an Azure Hub-and-Spoke network architecture using Terraform.

## Components

- Hub Virtual Network
- Spoke1 Virtual Network
- Spoke2 Virtual Network
- Azure Firewall Premium
- Azure Firewall Policy
- User Defined Routes
- Network Security Groups
- Windows Server Virtual Machines

## Traffic Flow

Internet
      │
Azure Firewall
      │
 Hub VNet
   │     │
Spoke1  Spoke2
