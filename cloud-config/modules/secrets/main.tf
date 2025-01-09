# https://stackoverflow.com/questions/62943824/terraform-gcp-secret-manager-for-each-for-multiple-secrets-error
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_regional_secret
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

resource "google_secret_manager_secret" "app" {
  for_each = var.secret_ids_list
  secret_id = each.key

  labels = {
    label = var.label
  }

  replication {
    auto {}
  }
}