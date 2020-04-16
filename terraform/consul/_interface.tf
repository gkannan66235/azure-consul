# Required variables (defined in terraform.tfvars)
variable "auto_join_subscription_id" {
  type = string
}

variable "auto_join_client_id" {
  type = string
}

variable "auto_join_client_secret" {
  type = string
}

variable "auto_join_tenant_id" {
  type = string
}

# Optional variables
variable "consul_version" {
  default     = "1.7.2"
  description = "Consul version to use"
}

variable "cluster_size" {
  default     = "3"
  description = "Number of instances to launch in the cluster"
}

variable "consul_vm_size" {
  default     = "Standard_A1_v2"
  description = "Azure virtual machine size for Consul cluster"
}

variable "os" {
  # Case sensitive
  # As of 20-JUL-2017, the RHEL images on Azure do not support cloud-init, so
  # we have disabled support for RHEL on Azure until it is available.
  # https://docs.microsoft.com/en-us/azure/virtual-machines/linux/using-cloud-init
  default = "ubuntu"

  description = "Operating System to use (only 'ubuntu' for now)"
}

variable "private_key_filename" {
  default     = "private_key.pem"
  description = "Name of the SSH private key"
}

output "consul_private_ips" {
  value = formatlist(
    "ssh %s@%s",
    module.consul_azure.os_user,
    module.consul_azure.consul_private_ips,
  )
}

