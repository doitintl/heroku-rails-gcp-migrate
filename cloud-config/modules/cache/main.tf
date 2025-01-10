
# default - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance

# resource "google_compute_network" "redis-network" {
#   name = "redis-test-network"
# }

# resource "google_compute_global_address" "service_range" {
#   name          = "address"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = google_compute_network.redis-network.id
# }

# resource "google_service_networking_connection" "private_service_connection" {
#   network                 = google_compute_network.redis-network.id
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.service_range.name]
# }

resource "google_redis_instance" "cache" {
  name           = var.redis_instance_name
  memory_size_gb = var.memory_size_gb

  location_id             = var.zone

#   authorized_network = google_compute_network.redis-network.id
#   connect_mode       = "PRIVATE_SERVICE_ACCESS"

#   depends_on = [google_service_networking_connection.private_service_connection]


#   redis_version     = "REDIS_4_0"
#   display_name      = "Terraform Test Instance"
  reserved_ip_range = var.reserved_ip_range

#   labels = {
#     my_key    = "my_val"
#     other_key = "other_val"
#   }

#   maintenance_policy {
#     weekly_maintenance_window {
#       day = "TUESDAY"
#       start_time {
#         hours = 0
#         minutes = 30
#         seconds = 0
#         nanos = 0
#       }
#     }
#   }

#   persistence_config {
#     persistence_mode = "RDB"
#     rdb_snapshot_period = "TWELVE_HOURS"
#   }

  lifecycle {
    prevent_destroy = true
  }
}