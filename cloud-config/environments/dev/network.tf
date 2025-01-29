# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering


module "gcp_network" {
  source  = "terraform-google-modules/network/google"
  version = ">= 4.0.1"

  project_id   = var.project_id
  network_name = local.network_name

  subnets = [
    {
      subnet_name   = "bastion"
      subnet_ip     = "10.250.0.0/29"
      subnet_region = var.region
    },
    {
      subnet_name   = "serverless-connector"
      subnet_ip     = "10.249.0.0/28"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    (local.subnet_name) = [
    #   {
    #     range_name    = local.pods_range_name
    #     ip_cidr_range = "192.168.0.0/18"
    #   },
    #   {
    #     range_name    = local.svc_range_name
    #     ip_cidr_range = "192.168.64.0/18"
    #   },
    ]
  }
}