variable "server_name" {
  type        = string
  description = "The unique name of the server instance"
}

variable "cpu" {
  type        = number
  description = "Number of CPUs allocated to the server"
  default     = 2
}

variable "memory" {
  type        = string
  description = "Amount of RAM allocated to the server"
  default     = "2G"
}

variable "disk" {
  type        = string
  description = "Disk size allocated to the server"
  default     = "10G"
}
