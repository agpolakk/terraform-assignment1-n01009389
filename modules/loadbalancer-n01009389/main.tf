resource "azurerm_public_ip" "lb_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name                = "BackendPool"
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "tcpProbe" {
  name                = "tcpProbe"
  # resource_group_name = azurerm_lb.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http_rule" {
  name                        = "HTTP"
  # resource_group_name         = var.resource_group_name
  loadbalancer_id             = azurerm_lb.lb.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  frontend_ip_configuration_id = azurerm_lb.lb.frontend_ip_configuration[0].id
  # backend_address_pool_id     = azurerm_lb_backend_address_pool.lb_backend_pool.id
  probe_id                    = azurerm_lb_probe.tcpProbe.id

  protocol      = "Tcp"
  frontend_port = 80
  backend_port  = 80
}
