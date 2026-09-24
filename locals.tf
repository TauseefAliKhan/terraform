locals {
  project_name = "devops-terraform"
  environment  = "prod"

  common_tags = {
    project     = local.project_name
    environment = local.environment
    managed_by  = "terraform"
  }
}