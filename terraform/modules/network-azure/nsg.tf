resource "azurerm_network_security_group" "public" {
  name                = "${var.network_name}-public"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# resource "azurerm_network_security_rule" "consul-ui" {
#   name                        = "${var.network_name}-consul-ui"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.public.name

#   priority  = 100
#   direction = "Inbound"
#   access    = "Allow"
#   protocol  = "Tcp"

#   source_address_prefix      = "*"
#   source_port_range          = "*"
#   destination_port_range     = "8500"
#   destination_address_prefix = "*"
# }
# Private Subnet NSG Rules

resource "azurerm_network_security_group" "private" {
  name                = "${var.network_name}-private"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "consul-ui"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8500"
    source_address_prefix      = "*" # 205.145.64.0/18
    destination_address_prefix = "*"
  }
}