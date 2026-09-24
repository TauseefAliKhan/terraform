# Resource group
resource "azurerm_resource_group" "devops_terraform_rg" {
  name     = "${local.project_name}-${local.environment}-rg"
  location = var.location
}


