locals {
  env                    = "dev"
  network_name           = "my-app-network-${local.env}"
  subnet_name            = "my-app-subnet"
  subnet_names           = [for subnet_self_link in module.gcp_network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
  node_count             = 1
}

provider "google" {
  project = var.project_id
}

# TODO: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest
# - create service project, link to shared vpc host project, enable APIs

# create secrets (without versions for security purpose)
module "secrets" {
  source          = "../../modules/secrets"
  project_id      = var.project_id
  env             = local.env
  secret_ids_list = var.secret_ids
}

