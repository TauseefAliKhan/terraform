# APP VM
resource "azurerm_linux_virtual_machine" "devops_terraform_app_vm" {
  name                = "${local.project_name}-app-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  admin_username = "terraform"

  network_interface_ids = [
    azurerm_network_interface.devops_terraform_nic["application"].id
  ]

  admin_ssh_key {
    username   = "terraform"
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

  tags = local.common_tags

}

# DB VM
resource "azurerm_linux_virtual_machine" "devops_terraform_db_vm" {
  name                = "${local.project_name}-db-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  admin_username = "terraform"
  network_interface_ids = [
    azurerm_network_interface.devops_terraform_nic["database"].id
  ]

  admin_ssh_key {
    username   = "terraform"
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

  tags = local.common_tags

}