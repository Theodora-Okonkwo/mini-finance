```
# Mini Finance — Azure Deployment

A static web application deployed on Microsoft Azure using Terraform for infrastructure provisioning and Ansible for configuration management and deployment.

---

## What This Project Does

- Provisions Azure infrastructure (Resource Group, VNet, Subnet, NSG, Public IP, Ubuntu VM) using Terraform
- Configures the VM and deploys the Mini Finance static site using Ansible
- Verifies the deployment returns HTTP 200 automatically as part of the Ansible playbook

---

## Project Structure

```
mini-finance/
├─ terraform/
│  ├─ providers.tf        # AzureRM provider + version lock
│  ├─ variables.tf        # Input variable declarations
│  ├─ terraform.tfvars    # Your values — DO NOT COMMIT
│  ├─ main.tf             # All Azure resources
│  └─ outputs.tf          # Public IP, SSH command, site URL
├─ ansible/
│  ├─ inventory.ini       # Target hosts + SSH config — DO NOT COMMIT
│  └─ site.yml            # Multi-play: install → deploy → verify
├─ .gitignore
└─ README.md
```

---

## Prerequisites

- Azure CLI — logged in via `az login`
- Terraform >= 1.3.0
- Ansible >= 2.12
- An RSA SSH key pair (Azure does not accept ed25519 by default)

---

## Secrets & Sensitive Files

The following files are listed in `.gitignore` and must never be committed:

| File | Why |
|---|---|
| `terraform/terraform.tfvars` | Contains your SSH key path and usernames |
| `ansible/inventory.ini` | Contains the public IP of your VM |
| `terraform/terraform.tfstate` | Contains full infrastructure state including sensitive values |
| `terraform/.terraform/` | Provider plugins — not needed in version control |

To use this repo on a new machine, create these files locally from the examples below.

### terraform/terraform.tfvars — create this manually

```
location            = "your-azure-region"
resource_group_name = "your-resource-group-name"
vm_admin_username   = "your-admin-username"
ssh_public_key_path = "~/.ssh/your-rsa-key.pub"
vm_size             = "Standard_B2ms"
```

### ansible/inventory.ini — create this manually after terraform apply

```
[web]
<YOUR_PUBLIC_IP>

[web:vars]
ansible_user=your-admin-username
ansible_ssh_private_key_file=~/.ssh/your-rsa-key
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

---

## Usage

### 1. Provision infrastructure

```
cd terraform/
terraform init
terraform plan
terraform apply
```

### 2. Get the public IP

```
terraform output public_ip
```

### 3. Update inventory

Add the public IP to ansible/inventory.ini

### 4. Test SSH connectivity

```
ssh -i ~/.ssh/your-rsa-key azureuser@<PUBLIC_IP> "hostname"
```

### 5. Run Ansible

```
cd ../ansible/
ansible -i inventory.ini web -m ping
ansible-playbook -i inventory.ini site.yml
```

### 6. Open in browser

```
http://<PUBLIC_IP>
```

---

## Clean Up

Destroy all resources when done to avoid Azure charges:

```
cd terraform/
terraform destroy
```

---

## Application

Mini Finance static site — source: https://github.com/pravinmishraaws/mini_finance
```