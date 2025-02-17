# Terraform Setup Guide

## Overview
This guide provides steps to upgrade Terraform using `tfenv`, authenticate with Azure CLI using a Service Principal, and configure the Azure provider with a remote backend for storing Terraform state files.

---

## Key Steps

### 1. **Upgrade Terraform Version Using `tfenv`**
To ensure you are using the correct Terraform version, install and use `tfenv`:

#### **Install `tfenv`** (if not already installed)
```bash
# Install tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* /usr/local/bin/
```

#### **Install and Use a Specific Terraform Version**
```bash
# Install Terraform version 1.10.5 (or latest required version)
tfenv install 1.10.5

# Set Terraform version globally
tfenv use 1.10.5

# Verify version
terraform -version
```

---

### 2. **Authenticate Using Azure CLI with a Service Principal**
To avoid manual login, authenticate Terraform using a Service Principal.

#### **Create a Service Principal**
```bash
az ad sp create-for-rbac --name "terraform-sp" --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
```
The output will contain:
```json
{
  "appId": "<CLIENT_ID>",
  "displayName": "terraform-sp",
  "password": "<CLIENT_SECRET>",
  "tenant": "<TENANT_ID>"
}
```

#### **Export Environment Variables**
```bash
export ARM_CLIENT_ID="<CLIENT_ID>"
export ARM_CLIENT_SECRET="<CLIENT_SECRET>"
export ARM_SUBSCRIPTION_ID="YOUR_SUBSCRIPTION_ID"
export ARM_TENANT_ID="<TENANT_ID>"
```

---

### 3. **Configure `provider.tf` with AzureRM Provider**
Create a `provider.tf` file with the required provider configuration:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.8.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # Optional if using environment variables
}
```

---

### 4. **Set Up Remote Backend with Azure Storage**
To store the Terraform state file remotely, create an Azure Storage Account.

#### **Create an Azure Storage Account**
```bash
az storage account create \
  --name terraformstatestorage \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS
```

#### **Create a Storage Container**
```bash
az storage container create --name terraform-state --account-name terraformstatestorage
```

#### **Configure Backend in `backend.tf`**
Create a `backend.tf` file:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name   = "myResourceGroup"
    storage_account_name  = "terraformstatestorage"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}
```

#### **Initialize the Remote Backend**
```bash
terraform init
```

---

## **Final Steps**
After completing the setup, run the following commands to verify and apply the Terraform configuration:

```bash
terraform validate  # Check for syntax issues
terraform plan      # Preview the execution plan
terraform apply     # Apply the changes
```

This ensures Terraform is correctly configured with Azure and using the latest version.

---

## **Troubleshooting**
- **Invalid Provider Configuration**: Ensure `features {}` is present in `provider.tf`.
- **Authentication Issues**: Double-check Azure CLI login (`az login`) and Service Principal credentials.
- **Remote Backend Issues**: Ensure the Azure Storage Account exists and you have correct permissions.

For further help, refer to the [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs).