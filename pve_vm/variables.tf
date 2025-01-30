variable "name" {
  type        = string
  description = "Common name for resources"
}

variable "tags" {
  type        = list(any)
  description = "Tags for resources"
}

variable "node_name" {
  type        = string
  description = "Proxmox node name"
}

variable "vm_id" {
  type        = number
  default     = 666
  description = "Virtual machine ID"
}

variable "instance_count" {
  type        = number
  description = "How many to deploy"
  default     = 1
}

variable "disks" {
  type = any
  default = []
}

variable "image" {
  type        = string
  description = "Image ID"
}

variable "disk_size" {
  type        = number
  default     = 20
  description = "How big should the root disk be"
}

variable "ansible_dir" {
  type        = string
  description = "Relative path to the ansible directory from the root module"
  default     = "../ansible"
}

variable "cpu_cores" {
  type        = number
  default     = 1
  description = "Number of CPU cores"
}

variable "memory" {
  type        = number
  default     = 512
  description = "Amount of memory in MB"
}

variable "network_devices" {
  type        = map(any)
  description = "Network device bridges and their ip address and gateway"
}

variable "firewall_rules" {
  type        = any
  default     = []
  description = "List of inbound firewall rules"
}

variable "storage_pool" {
  type = string
  default = "local-zfs"
  description = "Storage pool to use"
}
