# VNet Peering and Network Infrastructure Deployment

## Overview
This Terraform configuration sets up virtual network peering between two VNets, provisions subnets, security groups, public IPs, virtual machines, and enforces network security.

## Architecture
The deployment consists of:
- **Two Virtual Networks (VNets)**: `vnet-A` and `vnet-B`
- **Subnets** for app services and private endpoints
- **VNet Peering** between `vnet-A` and `vnet-B`
- **Network Security Groups (NSGs)** with security rules
- **Public IPs** for VMs
- **Virtual Machines (VMs)** with SSH key authentication

## Deployment Steps

### Prerequisites
- Terraform installed on your system
- Azure CLI installed and authenticated
- SSH key (`id_rsa.pub`) for VM authentication

### Steps to Deploy
1. **Initialize Terraform**
   ```sh
   terraform init
   ```
2. **Plan the Deployment**
   ```sh
   terraform plan
   ```
3. **Apply the Configuration**
   ```sh
   terraform apply -auto-approve
   ```

## Key Features
### 1. Virtual Network Peering
This setup enables seamless communication between `vnet-A` and `vnet-B` through bidirectional peering:
```terraform
resource "azurerm_virtual_network_peering" "peerA_to_peerB" {
  name                      = "peerA-to-peerB"
  resource_group_name       = azurerm_resource_group.infra.name  
  virtual_network_name      = azurerm_virtual_network.vnet-A.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-B.id
}

resource "azurerm_virtual_network_peering" "peerB_to_peerA" {
  name                      = "peerB-to-peerA"
  resource_group_name       = azurerm_resource_group.infra.name  
  virtual_network_name      = azurerm_virtual_network.vnet-B.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-A.id
}
```
- Allows resources in both VNets to communicate with each other securely.
- No need for a VPN or additional routing configurations.

### 2. Subnet and NSG Configuration
- **Subnets** are created within each VNet to segment traffic and enhance security.
- **NSGs** control inbound/outbound traffic rules to allow only necessary traffic.

### 3. Public IPs & VM Setup
- **Public IPs** allow external access to VMs.
- **Ubuntu-based VMs** provisioned with SSH key authentication for secure access.

## Security Considerations
- **NSGs enforce strict rules**, allowing only necessary ports.
- **Password authentication is disabled** on VMs, requiring SSH keys.
- **VNet peering ensures private communication**, reducing exposure to the internet.

## Cleanup
To delete all resources, run:
```sh
terraform destroy -auto-approve
```

## Future Enhancements
- Implement Private DNS for secure internal name resolution.
- Add monitoring and logging solutions (Azure Monitor, Log Analytics).
- Automate security rule updates using Terraform dynamic blocks.

## Conclusion
This setup provides a scalable, secure, and well-structured networking environment within Azure, leveraging VNet Peering, NSGs, and secure VM access.