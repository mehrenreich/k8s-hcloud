variable "hcloud_token" {
  description = "(Required) Token for accessing the Hetzner API"
  type        = string
  sensitive   = true
}

variable "kubernetes_controllers" {
  description = "(Optional) Number of K8s Controller instances"
  type        = number
  default     = 1
}

variable "kubernetes_nodes" {
  description = "(Optional) Number of K8s Node instances"
  type        = number
  default     = 2
}

variable "network_ip_range" {
  description = "(Optional) Network CIDR"
  type        = string
  default     = "172.16.0.0/16"
}

variable "network_subnet_ip_range" {
  description = "(Optional) Network Subnet CIDR"
  type        = string
  default     = "172.16.0.0/24"
}

variable "network_zone" {
  description = "(Optional) Network zone"
  type        = string
  default     = "eu-central"
}

variable "image" {
  description = "(Optional) Boot image"
  type        = string
  default     = "ubuntu-20.04"
}

variable "server_types" {
  description = "(Optional) Map of server types"
  type        = map(string)
  default = {
    controller = "cpx11",
    node       = "cpx11"
  }
}

variable "location" {
  description = "(Optional) Location"
  type        = string
  default     = "hel1"
}

variable "ssh_public_key" {
  description = "(Required) SSH public key file"
  type        = string
}
