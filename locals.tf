locals {
  project_name = "devops-terraform"
  environment  = "dev"

  common_tags = {
    project     = local.project_name
    environment = local.environment
    managed_by  = "terraform"
  }
}