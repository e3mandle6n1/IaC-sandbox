output "app_vnet_id" {
  description = "Resource ID of app-vnet."
  value       = azurerm_virtual_network.app.id
}

output "hub_vnet_id" {
  description = "Resource ID of hub-vnet."
  value       = azurerm_virtual_network.hub.id
}

output "frontend_subnet_id" {
  description = "Resource ID of the frontend subnet."
  value       = azurerm_subnet.frontend.id
}

output "backend_subnet_id" {
  description = "Resource ID of the backend subnet."
  value       = azurerm_subnet.backend.id
}

output "azure_firewall_subnet_id" {
  description = "Resource ID of AzureFirewallSubnet."
  value       = azurerm_subnet.firewall.id
}
