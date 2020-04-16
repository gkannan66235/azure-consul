terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "consul-dev-rg"
  location = "eastus"
}

module "ssh_key" {
  source = "../modules/ssh-keypair-data"

  private_key_filename = var.private_key_filename
}

module "network" {
  source                = "../modules/network-azure"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  network_name          = "consul-dev"
  network_cidr          = "10.0.0.0/24"
  network_cidrs_public  = "10.0.0.0/27"
  network_cidrs_private = "10.0.0.32/27"
  os                    = var.os
  public_key_data       = module.ssh_key.public_key_data
  backend_address_pool_id   = module.network.backend_address_pool_id
}

module "consul_azure" {
  source                    = "../modules/consul-azure"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_resource_group.main.location
  consul_environment        = "consul-dev"
  cluster_size              = var.cluster_size
  subnet_private_id         = module.network.subnet_private_id
  backend_address_pool_id   = module.network.backend_address_pool_id
  nat_rule_id               = module.network.nat_rule_id
  consul_version            = var.consul_version
  vm_size                   = var.consul_vm_size
  os                        = var.os
  public_key_data           = module.ssh_key.public_key_data
  auto_join_subscription_id = var.auto_join_subscription_id
  auto_join_tenant_id       = var.auto_join_tenant_id
  auto_join_client_id       = var.auto_join_client_id
  auto_join_client_secret   = var.auto_join_client_secret
}

