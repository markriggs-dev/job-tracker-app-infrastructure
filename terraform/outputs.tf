output "vps_ip" {
  description = "Public IP address of the VPS — point your DuckDNS subdomain at this"
  value       = linode_instance.job_tracker.ip_address
}

output "ssh_command" {
  description = "SSH command to connect to the VPS"
  value       = "ssh root@${linode_instance.job_tracker.ip_address}"
}
