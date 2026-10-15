terraform {
  required_version = ">= 1.0.0"
  required_providers {
    multipass = {
      source  = "larstwiest/multipass"
      version = "~> 1.4.0"
    }
  }

  backend "local" {}
}

provider "multipass" {}

module "app_server" {
  for_each = var.server_configs

  source      = "./modules/app_server"
  server_name = "kijanikiosk-${each.key}"
  cpu         = each.value.cpu
  memory      = each.value.memory
  disk        = each.value.disk
}
