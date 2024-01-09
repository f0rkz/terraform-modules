# pve_vm

This module can create a proxmox vm.

[//]: # (BEGIN_TF_DOCS)
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >= 0.43 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_file.cloud_config](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_firewall_rules.inbound](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_firewall_rules) | resource |
| [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_dir"></a> [ansible\_dir](#input\_ansible\_dir) | Relative path to the ansible directory from the root module | `string` | `"../ansible"` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | Number of CPU cores | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | How big should the root disk be | `number` | `20` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | n/a | `any` | `[]` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of inbound firewall rules | `any` | `[]` | no |
| <a name="input_image"></a> [image](#input\_image) | Image ID | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | How many to deploy | `number` | `1` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory in MB | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | Common name for resources | `string` | n/a | yes |
| <a name="input_network_devices"></a> [network\_devices](#input\_network\_devices) | Network device bridges and their ip address and gateway | `list(map(any))` | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `list(any)` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | Virtual machine ID | `number` | `666` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm"></a> [vm](#output\_vm) | n/a |

[//]: # (END_TF_DOCS)
