resource "azurerm_subnet" "public" {
  name                 = "${var.network_name}-public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.network_cidrs_public
}
# Attach NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

resource "azurerm_subnet" "private" {
  name                 = "${var.network_name}-private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.network_cidrs_private
}
# Attach NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private.id
}