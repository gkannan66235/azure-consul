# Required Variables
variable "network_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "os" {
  type = string
}

variable "public_key_data" {
  type = string
}

# Optional Variables
variable "network_cidr" {
  default = "10.0.0.0/16"
}

variable "network_cidrs_public" {
  default = "10.0.0.0/24"
}

variable "network_cidrs_private" {
  default = "10.0.1.0/24"
}

# Outputs
output "virtual_network_name" {
  value = "${azurerm_virtual_network.main.name}"
}

output "virtual_network_id" {
  value = "${azurerm_virtual_network.main.id}"
}

output "subnet_public_ids" {
  value = ["${azurerm_subnet.public.*.id}"]
}

output "subnet_private_ids" {
  value = ["${azurerm_subnet.private.*.id}"]
}

output "private_subnet1" {
  value = "${azurerm_subnet.private.0.id}"
}
