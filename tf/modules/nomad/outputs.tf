output "names" {
  value       = [for instance in google_compute_instance.nomad_servers : instance.name]
  description = "Names of Nomad server instances"
}

output "external_server_ips" {
  value       = [for instance in google_compute_instance.nomad_servers : instance.network_interface[0].access_config[0].nat_ip]
  description = "External IP addresses of Nomad server instances"
}

output "internal_server_ips" {
  value       = [for instance in google_compute_instance.nomad_servers : instance.network_interface[0].network_ip]
  description = "External IP addresses of Nomad server instances"
}


output "internal_client_ips" {
  value       = [for instance in google_compute_instance.nomad_client : instance.network_interface[0].network_ip]
  description = "External IP addresses of Nomad client instances"
}

output "fqdn" {
  value       = trimsuffix(google_dns_record_set.default.name, ".")
  description = "FQDN of the Nomad server"
}
