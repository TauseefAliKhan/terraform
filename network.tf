# Vnet
resource "azurerm_virtual_network" "devops_terraform_vnet" {
  name                = "devops-terraform-vnet"
  location            = azurerm_resource_group.devops_terraform_rg.location
  resource_group_name = azurerm_resource_group.devops_terraform_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "devops_terraform_subnet" {
  name                 = "devops-terraform-subnet"
  resource_group_name  = azurerm_resource_group.devops_terraform_rg.name
  virtual_network_name = azurerm_virtual_network.devops_terraform_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#Public IP
resource "azurerm_public_ip" "devops_terraform_public_ip" {
  name                = "devops-terraform-public-ip"
  location            = azurerm_resource_group.devops_terraform_rg.location
  resource_group_name = azurerm_resource_group.devops_terraform_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#NIC
resource "azurerm_network_interface" "devops_terraform_nic" {
  name                = "devops-terraform-nic"
  location            = azurerm_resource_group.devops_terraform_rg.location
  resource_group_name = azurerm_resource_group.devops_terraform_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops_terraform_public_ip.id
  }
}

