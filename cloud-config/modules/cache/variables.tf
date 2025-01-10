variable "project_id" {}

variable "env" {}

variable "zone" {}

variable "redis_instance_name" {
  type = string
}

variable "memory_size_gb" {
  type = number
  default = 1
}

variable "reserved_ip_range" {
  type = string
}
