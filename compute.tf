# Virtual Machine
resource "azurerm_linux_virtual_machine" "devops_terraform_vm" {
  name                = "devops-terraform-vm"
  location            = azurerm_resource_group.devops_terraform_rg.location
  resource_group_name = azurerm_resource_group.devops_terraform_rg.name
  size                = "Standard_B2ats_v2"

  admin_username = "devops_terraform"

  network_interface_ids = [
    azurerm_network_interface.devops_terraform_nic.id
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