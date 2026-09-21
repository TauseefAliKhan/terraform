terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group
resource "azurerm_resource_group" "rg_devops_terraform" {
  name     = "rg-devops-terraform"
  location = "Central India"
}

# Vnet
resource "azurerm_virtual_network" "devops_terraform_vnet" {
  name                = "devops-terraform-vnet"
  location            = azurerm_resource_group.rg_devops_terraform.location
  resource_group_name = azurerm_resource_group.rg_devops_terraform.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "devops_terraform_subnet" {
  name                 = "devops-terraform-subnet"
  resource_group_name  = azurerm_resource_group.rg_devops_terraform.name
  virtual_network_name = azurerm_virtual_network.devops_terraform_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#Public IP
resource "azurerm_public_ip" "devops_terraform_public_ip" {
  name                = "devops-terraform-public-ip"
  location            = azurerm_resource_group.rg_devops_terraform.location
  resource_group_name = azurerm_resource_group.rg_devops_terraform.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Network Security Group
resource "azurerm_network_security_group" "devops_terraform_nsg" {
  name                = "devops-terraform-nsg"
  location            = azurerm_resource_group.rg_devops_terraform.location
  resource_group_name = azurerm_resource_group.rg_devops_terraform.name

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

#NIC
resource "azurerm_network_interface" "devops_terraform_nic" {
  name                = "devops-terraform-nic"
  location            = azurerm_resource_group.rg_devops_terraform.location
  resource_group_name = azurerm_resource_group.rg_devops_terraform.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops_terraform_public_ip.id
  }
}

#NIC NSG Association
resource "azurerm_network_interface_security_group_association" "devops_terraform_nic_nsg" {
  network_interface_id      = azurerm_network_interface.devops_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.devops_terraform_nsg.id
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "devops_terraform_vm" {
  name                = "devops-terraform-vm"
  location            = azurerm_resource_group.rg_devops_terraform.location
  resource_group_name = azurerm_resource_group.rg_devops_terraform.name
  size                = "Standard_B2s_v2"

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


