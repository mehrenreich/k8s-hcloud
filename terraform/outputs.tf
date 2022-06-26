output "controllers" {
  description = "Config map for all Controllers"
  value       = hcloud_server.controller.*
}

output "nodes" {
  description = "Config map for all Nodes"
  value       = hcloud_server.node.*
}
