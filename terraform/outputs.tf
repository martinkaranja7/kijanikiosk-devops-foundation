output "api_server_ip" {
  description = "Public IP address of the API server"
  value       = module.app_server["api"].server_ip
}

output "payments_server_ip" {
  description = "Public IP address of the Payments server"
  value       = module.app_server["payments"].server_ip
}

output "logs_server_ip" {
  description = "Public IP address of the Logs server"
  value       = module.app_server["logs"].server_ip
}

output "all_ssh_commands" {
  description = "Copy-pasteable SSH commands for all servers"
  value = {
    api      = module.app_server["api"].ssh_command
    payments = module.app_server["payments"].ssh_command
    logs     = module.app_server["logs"].ssh_command
  }
}

