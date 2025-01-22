locals {
  env = "shared"
  service_apis           = toset(["compute.googleapis.com",
                            "storage.googleapis.com",
                            "artifactregistry.googleapis.com",
                            "cloudbuild.googleapis.com"])
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

module "registry" {
  source        = "../../modules/registry"
  project_id    = var.project_id
  env           = local.env
  location      = var.region
  repository_id = var.repository_id
  depends_on = [google_project_service.project]
}
