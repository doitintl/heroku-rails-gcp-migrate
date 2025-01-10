locals {
  env                    = "dev"
  network_name           = "my-app-network-${local.env}"
  subnet_name            = "my-app-subnet"
  # subnet_names           = [for subnet_self_link in module.gcp_network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
  service_apis           = toset(["compute.googleapis.com",
                            "storage.googleapis.com",
                            "servicenetworking.googleapis.com",
                            "vpcaccess.googleapis.com",
                            "sqladmin.googleapis.com",
                            "secretmanager.googleapis.com",
                            "redis.googleapis.com",
                            "artifactregistry.googleapis.com",
                            "dns.googleapis.com",
                            "cloudbuild.googleapis.com",
                            "run.googleapis.com"])
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

# - service apis
resource "google_project_service" "project" {
  for_each = local.service_apis
  service = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}


# TODO: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
# - create service project, link to shared vpc host project, enable APIs

# TODO: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
# - create service accounts and bind iam policies
# - network
# - database
# - cache
# - apps

# create secrets (without versions for security purpose)
# module "secrets" {
#   source          = "../../modules/secrets"
#   project_id      = var.project_id
#   env             = local.env
#   secret_ids_list = var.secret_ids
# }
