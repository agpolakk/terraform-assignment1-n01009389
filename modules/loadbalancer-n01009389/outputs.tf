output "load_balancer_name" {
  description = "Name of the provisioned load balancer."
  value       = azurerm_lb.lb.name
}
