 #Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${var.Environment}"
  location = var.my_region
   tags = {
    "type"="LoadBalancerRelated"}
}

# Create load balancerIP
resource "azurerm_public_ip" "LoadBalancerIP" {
  name                = "PublicIPForLB"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  sku = "Standard"
  allocation_method   = "Static"
  depends_on = [azurerm_resource_group.rg]

}

 # Create load balancer
 resource "azurerm_lb" "LoadBalancer" {
  name                = "LoadBalancer"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  sku = "Standard"
  depends_on = [azurerm_public_ip.LoadBalancerIP]

  frontend_ip_configuration {
    name                 = "Front-endIP"
    public_ip_address_id = azurerm_public_ip.LoadBalancerIP.id
  }

}

 # Create backend addrress pool
 resource "azurerm_lb_backend_address_pool" "BackendAdrress" {
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  name            = "BackEndAddressPool"
  depends_on = [azurerm_lb.LoadBalancer]

}




# Create probe
 resource "azurerm_lb_probe" "ProbeA" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.LoadBalancer.id
  name                = "ProbeA"
  port                = 8080

}

 # Create rule
 resource "azurerm_lb_rule" "RuleA" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.LoadBalancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
   backend_address_pool_ids = [azurerm_lb_backend_address_pool.BackendAdrress.id]
  frontend_ip_configuration_name = "Front-endIP"
}










