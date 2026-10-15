output "server_ip" {
  description = "The public IP address of the provisioned server"
  value       = multipass_instance.server.ipv4
}

output "ssh_command" {
  description = "Convenience SSH command for the server"
  value       = "ssh ubuntu@${multipass_instance.server.ipv4}"
}

