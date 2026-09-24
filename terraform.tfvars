resource_group_name = "devops-terraform-dev-rg"
location            = "South India"
vm_size             = "Standard_D2s_v3"
vnet_address_space  = "10.0.0.0/16"
subnets = {
  management  = "10.0.0.0/24"
  application = "10.0.1.0/24"
  database    = "10.0.2.0/24"
}