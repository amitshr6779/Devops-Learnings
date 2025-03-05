# Azure Web App Deployment using Terraform

## Overview
This Terraform configuration automates the deployment of an **Azure Web App** (Linux-based) within a **private network**. It provisions the necessary resources, including:

- An **Azure Service Plan** (App Service Plan)
- A **Linux Web App** for hosting a Node.js application
- **Private Endpoints** for secure access
- **Private DNS Zone** to resolve private IP addresses
- Virtual Network (VNet) integration for **internal-only access**

## Features
- **Automated Infrastructure Provisioning:** Uses Terraform to deploy and configure the infrastructure in a repeatable manner.
- **Private Network Access:** The Web App is secured via **Azure Private Endpoints**, preventing direct internet exposure.
- **DNS Resolution for Private Endpoints:** A **Private DNS Zone** is used to resolve the private IP of the Web App within the Virtual Network.
- **Virtual Network Links:** The Private DNS Zone is linked to multiple VNets for cross-network resolution.
- **Node.js Stack:** The Web App is configured to run **Node.js v18-LTS**.

---

## Deployment Steps
### Prerequisites
- **Terraform installed** (`v1.x.x` recommended)
- **Azure CLI installed** and logged in (`az login`)
- **Existing Resource Group and Virtual Network** (`infra-poc-rg`)
- **Storage Account for function app state (if needed for remote state storage)**

### Terraform Deployment
#### 1. Initialize Terraform
```sh
terraform init
```
#### 2. Plan the Deployment
```sh
terraform plan
```
#### 3. Apply the Configuration
```sh
terraform apply -auto-approve
```
Terraform will now create and configure all required resources.

---

## Security Considerations
- **Private Network Access Only:** The Web App is bound to a **private subnet**, ensuring no direct public access.
- **Private DNS Integration:** Prevents dependency on public DNS services and ensures resolution within Azure networks.
- **HTTPS-Only Configuration:** Enforces secure communication over TLS.
- **Firewall and NSG Considerations:** Ensure only trusted VNets and subnets can access the Web App.

---

## Private Endpoint Explanation
### What is a Private Endpoint?
A **Private Endpoint** provides a **private IP address** from the Virtual Network (VNet) to an **Azure PaaS service** (in this case, the Web App). This allows services to be accessed securely **without exposing them to the public internet**.

### Why Use a Private Endpoint?
- **Enhanced Security:** Eliminates public internet exposure.
- **Private Connectivity:** Enables secure communication between Azure resources within the same Virtual Network.
- **Reduces Data Exfiltration Risks:** Only authorized VNets and subnets can communicate with the Web App.

### How is the Private Endpoint Implemented?
1. **A Private Endpoint is created** for the Azure Web App.
2. **The Private Endpoint is assigned an IP** from the designated private subnet (`infra-poc02-subnet`).
3. **A Private DNS Zone (`privatelink.azurewebsites.net`)** is configured to map the Web App's private IP.
4. **The DNS Zone is linked** to multiple Virtual Networks for seamless resolution across different VNets.

By implementing Private Endpoints, the Web App remains isolated from the public internet, improving security while allowing trusted resources to access it securely.

---

## Enhancements & Future Improvements
- **Enable Logging & Monitoring** with Azure Monitor and Application Insights.
- **Configure CI/CD Pipelines** with Azure DevOps or GitHub Actions.
- **Use Azure Key Vault** for secure secret management (e.g., database credentials, API keys).
- **Integrate Load Balancer** for high availability in multi-region deployments.

---

## Cleanup
To remove the deployed resources, run:
```sh
terraform destroy -auto-approve
```
This will safely delete all infrastructure resources created by Terraform.

---

## Conclusion
This Terraform setup ensures a **secure, automated, and private deployment** of an Azure Web App using **Private Endpoints** and **DNS Integration**. It provides a scalable, repeatable infrastructure with improved security and network isolation.

---

### 🚀 Need further customization?
Feel free to modify the Terraform scripts to match your specific requirements (e.g., different app stacks, custom security policies, additional integrations).
