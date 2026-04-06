variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-mini-finance"
}

variable "vm_admin_username" {
  description = "Admin username for SSH access to the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Local path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa_azure.pub"
}

variable "vm_size" {
  description = "Azure VM SKU size"
  type        = string
  default     = "Standard_B2ms"
}