# Resource group
resource "azurerm_resource_group" "devops_terraform_rg" {
  name     = "${local.project_name}-rg"
  location = var.location
}


