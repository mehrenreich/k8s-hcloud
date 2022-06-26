terraform {
  required_version = ">= 1.0"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.33.2"
    }
  }

  cloud {
    organization = "mehrenreich"
    workspaces {
      name = "k8s-hcloud"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "default" {
  name       = "Default"
  public_key = var.ssh_public_key
}

resource "hcloud_network" "kubernetes" {
  name     = "kubernetes"
  ip_range = var.network_ip_range
}

resource "hcloud_network_subnet" "kubernetes" {
  network_id   = hcloud_network.kubernetes.id
  ip_range     = var.network_subnet_ip_range
  network_zone = var.network_zone
  type         = "cloud"
}

resource "hcloud_placement_group" "controllers" {
  name = "controllers"
  type = "spread"
}

resource "hcloud_placement_group" "nodes" {
  name = "nodes"
  type = "spread"
}

resource "hcloud_server" "controller" {
  count              = var.kubernetes_controllers
  name               = format("controller-%s", count.index + 1)
  image              = var.image
  location           = var.location
  server_type        = lookup(var.server_types, "controller")
  placement_group_id = hcloud_placement_group.controllers.id
  ssh_keys           = [hcloud_ssh_key.default.id]

  network {
    network_id = hcloud_network.kubernetes.id
  }
}

resource "hcloud_server" "node" {
  count              = var.kubernetes_nodes
  name               = format("node-%s", count.index + 1)
  image              = var.image
  location           = var.location
  server_type        = lookup(var.server_types, "node")
  placement_group_id = hcloud_placement_group.nodes.id
  ssh_keys           = [hcloud_ssh_key.default.id]

  network {
    network_id = hcloud_network.kubernetes.id
  }
}
