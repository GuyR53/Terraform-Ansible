# Terraform-AnsibleWeek6

## Goals:

<img width="826" alt="Screen Shot 2022-03-30 at 22 33 45" src="https://user-images.githubusercontent.com/93793111/160917591-5466d670-112e-4c07-84b1-7bfb598dfd6a.png">


### 1. Use Terraform to provision the infrastructure.
### 2. Use Ansible to deploy the NodeWeightTracker application.
### 3. Create two environments: Staging and Production.
### 4. Both environments must be identical except for the size of the vms (production ones must be larger).




## How to run

### Run the infrastructure from the root module which will use the sub modules.

### For Production infrastructure write on the CLI:
### terraform workspace select Production
### terraform apply -var-file=Production.tfvars
### You should use Production.tfvars file with these variables (change the Password):
#### Environment="production"
#### my_region="eastus"
#### size ="Standard_DS2_v2"
#### sku = "Standard_F2"
#### Instances="3"
#### default="3"
#### minimum="3"
#### Password="ChooseYourPassword"

### For Staging infrastructure write on the CLI:
### terraform workspace select Staging
### terraform apply -var-file=Staging.tfvars  
### You should use Staging.tfvars file with these variables (change the Password):
#### Environment="staging"
#### my_region="centralus"
#### size ="Standard_D2ads_v5"
#### sku = "Standard_D2ads_v5"
#### Instances="2"
#### default="2"
#### minimum="2"
#### Password="ChooseYourPassword"



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_LoadBalancer"></a> [LoadBalancer](#module\_LoadBalancer) | ./modules/LoadBalancer | n/a |
| <a name="module_ManagedDB"></a> [ManagedDB](#module\_ManagedDB) | ./modules/ManagedDB | n/a |
| <a name="module_Network"></a> [Network](#module\_Network) | ./modules/Network | n/a |
| <a name="module_ScaleSet"></a> [ScaleSet](#module\_ScaleSet) | ./modules/ScaleSet | n/a |
| <a name="module_VirtualMachines"></a> [VirtualMachines](#module\_VirtualMachines) | ./modules/ApplicationServer | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_my_region"></a> [my\_region](#input\_my\_region) | Value of the region I use | `string` | `"eastus"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Password"></a> [Password](#output\_Password) | n/a |
<!-- END_TF_DOCS -->
