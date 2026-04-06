output "public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.main.ip_address
}

output "ssh_command" {
  description = "Ready-to-use SSH command"
  value       = "ssh ${var.vm_admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "site_url" {
  description = "URL to access the Mini Finance site"
  value       = "http://${azurerm_public_ip.main.ip_address}"
}

output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.main.name
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.name
}