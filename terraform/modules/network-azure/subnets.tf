resource "azurerm_subnet" "public" {
  name                 = "${var.network_name}-public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.network_cidrs_public
}

resource "azurerm_subnet" "private" {
  name                 = "${var.network_name}-private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.network_cidrs_private
}
