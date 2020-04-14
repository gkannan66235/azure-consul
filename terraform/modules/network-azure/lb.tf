resource "azurerm_public_ip" "lb" {
  name                = "${var.network_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = "${var.network_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb" {
  name                = "BackEndAddressPool"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_lb_rule" "lb" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 8500
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = var.backend_address_pool_id
  probe_id                       = azurerm_lb_probe.lb.id
}

resource "azurerm_lb_probe" "lb" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "consul-ui"
  port                = 8500
}