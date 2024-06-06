locals {
  name            = var.name
  tags            = var.tags
  vm_id           = var.vm_id
  image           = var.image
  storage_pool    = var.storage_pool
  disk_size       = var.disk_size
  disks           = var.disks
  cpu_cores       = var.cpu_cores
  memory          = var.memory
  node_name       = var.node_name
  network_devices = var.network_devices
  firewall_rules  = var.firewall_rules
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = local.node_name

  source_raw {
    data = <<EOF
#cloud-config
hostname: ${var.name}
users:
  - name: ansible
    primary_group: ansible
    groups: sudo
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_import_id:
      - gh:f0rkz
packages:
  - qemu-guest-agent
runcmd:
  - sudo systemctl enable qemu-guest-agent
  - sudo systemctl start qemu-guest-agent
EOF

    file_name = "${local.name}.cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  name        = local.name
  description = "Managed by terraform f0rkznet/infra"
  tags        = local.tags

  node_name = local.node_name
  agent {
    enabled = false
  }

  cpu {
    cores = local.cpu_cores
    architecture = "x86_64"
    type = "max"
  }

  memory {
    dedicated = local.memory
  }

  disk {
    datastore_id = local.storage_pool
    file_id      = local.image
    interface    = "virtio0"
    size         = local.disk_size
  }

  dynamic "disk" {
    for_each = local.disks
    content {
      datastore_id = try(disk.value["datastore_id"], local.storage_pool)
      interface    = disk.value["interface"]
      size         = disk.value["size"]
      file_format  = "raw"
    }
  }

  initialization {
    datastore_id = local.storage_pool
    dynamic "ip_config" {
      for_each = local.network_devices
      content {
        ipv4 {
          address = ip_config.value["address"]
          gateway = ip_config.value["gateway"]
        }
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  dynamic "network_device" {
    for_each = local.network_devices
    content {
      bridge = network_device.value["bridge"]
      firewall = network_device.value["firewall"]
    }
  }

  operating_system {
    type = "l26"
  }

  serial_device {}

  lifecycle {
    ignore_changes = [
      id,
    ]
  }
}

resource "proxmox_virtual_environment_firewall_rules" "inbound" {
  count = length(local.firewall_rules) > 0 ? 1 : 0
  depends_on = [
    proxmox_virtual_environment_vm.this
  ]
  node_name = proxmox_virtual_environment_vm.this.node_name
  vm_id     = proxmox_virtual_environment_vm.this.id
  dynamic "rule" {
    for_each = local.firewall_rules
    content {
      type    = rule.value["type"]
      action  = rule.value["action"]
      comment = rule.value["comment"]
      source  = rule.value["source"]
      dest    = rule.value["dest"]
      dport   = rule.value["dport"]
      proto   = rule.value["proto"]
      log     = rule.value["log"]
    }
  }
}
