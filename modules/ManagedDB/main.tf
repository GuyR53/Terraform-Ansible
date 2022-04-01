
# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${var.Environment}"
  location = var.my_region
    tags = {
    type = "PostgresDataBaseRelated"
  }
}
# Create Managed DB
resource "azurerm_private_dns_zone" "guy" {
  name                = "guy.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [azurerm_resource_group.rg]

}

# Attach my virtusl network
resource "azurerm_private_dns_zone_virtual_network_link" "guy" {
  name                  = "GuynetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.guy.name
  virtual_network_id    = var.VirtualNetworkID
  resource_group_name   = azurerm_resource_group.rg.name
  depends_on = [azurerm_resource_group.rg]

}

# Create flexible server
resource "azurerm_postgresql_flexible_server" "guy" {
  name                   = "guy-psqlflexibleserver-${var.Environment}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = var.my_region
  version                = "12"
  delegated_subnet_id    = var.DBSubnet
  private_dns_zone_id    = azurerm_private_dns_zone.guy.id
  administrator_login    = "postgres"
  administrator_password = var.Password
  zone                   = "1"
  storage_mb = 32768
  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.guy]


}

# disable ssl for managed db
resource "azurerm_postgresql_flexible_server_configuration" "ssl_disable" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.guy.id
  value     = "off"
}
