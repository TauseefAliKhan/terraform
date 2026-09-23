#Network Security Group
resource "azurerm_network_security_group" "devops_terraform_nsg" {
  name                = "devops-terraform-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#NIC NSG Association
resource "azurerm_network_interface_security_group_association" "devops_terraform_nic_nsg" {
  network_interface_id      = azurerm_network_interface.devops_terraform_nic["application"].id
  network_security_group_id = azurerm_network_security_group.devops_terraform_nsg.id
}