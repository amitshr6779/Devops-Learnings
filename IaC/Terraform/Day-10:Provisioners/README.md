# Terraform Provisioners Overview

## Introduction
Terraform **Provisioners** allow executing scripts and commands on a resource after it has been created. They help in configuring servers, installing software, and handling any post-deployment setup tasks. However, their usage should be minimized in favor of configuration management tools like Ansible or cloud-init where possible.

## Types of Provisioners Used
### 1️⃣ **Local-Exec Provisioner**
The `local-exec` provisioner executes commands on the machine running Terraform, useful for logging, sending notifications, or triggering external scripts.

**Example:**
```hcl
provisioner "local-exec" {
  command = "echo 'Deployment started at ${timestamp()}' > deployment-timestamp.log"
}
```
✅ **Use Case:** Capturing deployment timestamps or executing scripts on the local machine.

### 2️⃣ **Remote-Exec Provisioner**
The `remote-exec` provisioner runs commands directly on a created resource using SSH.

**Example:**
```hcl
provisioner "remote-exec" {
  inline = [
    "sudo apt update",
    "sudo apt install -y nginx",
    "echo 'Hello, Nginx!' > /var/www/html/index.html",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx"
  ]

  connection {
    type        = "ssh"
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_public_ip.public_ip.ip_address
  }
}
```
✅ **Use Case:** Installing and configuring software, setting up applications post-deployment.

### 3️⃣ **File Provisioner**
The `file` provisioner copies local files to a remote server via SSH.

**Example:**
```hcl
provisioner "file" {
  source      = "./var.tf"
  destination = "/home/adminuser/var.tf"

  connection {
    type        = "ssh"
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_public_ip.public_ip.ip_address
  }
}
```
✅ **Use Case:** Transferring configuration files, scripts, or application code to the VM.

## Connection Block
All remote provisioners use the `connection` block to define SSH authentication.

```hcl
connection {
  type        = "ssh"
  user        = "adminuser"
  private_key = file("~/.ssh/id_rsa")
  host        = azurerm_public_ip.public_ip.ip_address
}
```
🔹 Ensure the SSH key exists and is correctly configured.
🔹 The VM should have SSH access enabled.

## Best Practices for Terraform Provisioners
1. **Use Provisioners as a Last Resort** – Prefer cloud-init, Ansible, or other automation tools.
2. **Use `depends_on` for Correct Execution Order** – Ensure resources are created before provisioning.
3. **Make Provisioning Idempotent** – Ensure commands can be rerun without side effects.
4. **Use `null_resource` for Independent Execution** – Helps when provisioning needs to run without recreating resources.

## Potential Enhancements
- Use **Terraform Cloud-Init** instead of provisioners for VM bootstrapping.
- Store logs of provisioner execution for debugging.
- Implement error handling to prevent failures during provisioning.

## Conclusion
Terraform provisioners help with automation but should be used sparingly. When possible, use declarative configuration tools to maintain infrastructure consistency and scalability.

---
📌 **Next Steps:** Optimize the provisioning process using Ansible or cloud-init for a more scalable approach.