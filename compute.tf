# APP VM
resource "azurerm_linux_virtual_machine" "devops_terraform_app_vm" {
  name                = "devops-terraform-app-vm"
  location            = azurerm_resource_group.devops_terraform_rg.location
  resource_group_name = azurerm_resource_group.devops_terraform_rg.name
  size                = var.vm_size

  admin_username = "devops_terraform"

  network_interface_ids = [
    azurerm_network_interface.devops_terraform_nic["application"].id
  ]

  admin_ssh_key {
    username   = "devops_terraform"
    public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

# DB VM
resource "azurerm_linux_virtual_machine" "devops_terraform_db_vm" {
  name                = "devops-terraform-db-vm"
  location            = azurerm_resource_group.devops_terraform_rg.location
  resource_group_name = azurerm_resource_group.devops_terraform_rg.name
  size                = var.vm_size

  admin_username = "devops_terraform"

  network_interface_ids = [
    azurerm_network_interface.devops_terraform_nic["database"].id
  ]

  admin_ssh_key {
    username   = "devops_terraform"
    public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}