
# Creates the network
module "Network" {
  source = "./modules/Network"
  Environment = var.Environment
  my_region = var.my_region
}

# Terraform module that reuse the code that creates virtual machines without scaleset
module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  # Creating virtual machines with the names and numbers as we pass in the list, the last machine is configuration machine with public IP
  vm_names = ["Ansible-Controler"]
  # Passing the app subnetID, creating the machines in the right subnet
  AppSubnetID = module.Network.AppSubnet
  Environment = var.Environment
  my_region = var.my_region
  size = var.size
  Password = var.Password

}

# Creates Load Balancer
module "LoadBalancer" {
  source = "./modules/LoadBalancer"
  Environment = var.Environment
  my_region = var.my_region



}

# Create ManagedDB
module "ManagedDB" {
  source = "./modules/ManagedDB"
  # Passing the networkID for the managed dbserver
  VirtualNetworkID = module.Network.NetworkID
  # Passing the subnet (private) for the managed dbserver
  DBSubnet = module.Network.DBSubnet
  Environment = var.Environment
  my_region = var.my_region
  Password = var.Password
}

#  creates VMSS
module "ScaleSet" {
  source = "./modules/ScaleSet"
  # Passing the App subnet id
  AppSubnetID = module.Network.AppSubnet
  # Passing the load balancer backend address pool id
  lb_backend_address_pool_id = module.LoadBalancer.lb_backend_address_pool_id
  Environment = var.Environment
  my_region = var.my_region
  Password = var.Password
  Instances = var.Instances
  default = var.default
  minimum = var.minimum
}






