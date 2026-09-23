output "app_vm_public_ip" {
  description = "Application VM Public IP Address"
  value       = azurerm_public_ip.devops_terraform_public_ip.ip_address
}

output "vm_private_ips" {
  description = "Private IP addresses of the VMs"
  value = {
    application_vm = azurerm_network_interface.devops_terraform_nic["application"].private_ip_address
    database_vm    = azurerm_network_interface.devops_terraform_nic["database"].private_ip_address
  }
}
