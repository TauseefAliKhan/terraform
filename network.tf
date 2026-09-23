# Vnet
resource "azurerm_virtual_network" "devops_terraform_vnet" {
  name                = "devops-terraform-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "devops_terraform_subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.devops_terraform_vnet.name
  address_prefixes     = [each.value]
}

#Public IP
resource "azurerm_public_ip" "devops_terraform_public_ip" {
  name                = "devops-terraform-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "devops_terraform_nic" {
  for_each            = var.subnets
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops_terraform_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.key == "application" ? azurerm_public_ip.devops_terraform_public_ip.id : null
  }

}