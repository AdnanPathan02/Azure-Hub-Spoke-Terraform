# Security Configuration

## Azure Firewall

Centralized security

---

## NSG

Spoke1 NSG

Spoke2 NSG

---

## DNAT

Firewall Public IP:8080

↓

VM1:3389

Firewall Public IP:8081

↓

VM2:3389

---

## UDR

Default Route

0.0.0.0/0

↓

Azure Firewall

---

## Public IP

Virtual Machines have NO Public IP.