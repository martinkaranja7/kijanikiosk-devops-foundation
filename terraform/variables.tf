variable "server_configs" {
  type = map(object({
    cpu    = number
    memory = string
    disk   = string
  }))
  description = "Map of server configurations for api, payments, and logs"
  default = {
    api = {
      cpu    = 2
      memory = "2G"
      disk   = "10G"
    }
    payments = {
      cpu    = 2
      memory = "2G"
      disk   = "10G"
    }
    logs = {
      cpu    = 2
      memory = "2G"
      disk   = "10G"
    }
  }
}

