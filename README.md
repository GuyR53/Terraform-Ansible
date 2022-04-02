# Terraform-AnsibleWeek6

## Goals:

<img width="826" alt="Screen Shot 2022-03-30 at 22 33 45" src="https://user-images.githubusercontent.com/93793111/160917591-5466d670-112e-4c07-84b1-7bfb598dfd6a.png">


 1. Use Terraform to provision the infrastructure.
 2. Use Ansible to deploy the NodeWeightTracker application.
 3. Create two environments: Staging and Production.
 4. Both environments must be identical except for the size of the vms (production ones must be larger).




## How to run

 Run the infrastructure from the root module which will use the sub modules.

 For Production infrastructure write on the CLI:
```
% terraform workspace select Production
% terraform apply -var-file=Production.tfvars
```
 You should use Production.tfvars file with these variables (change the Password):
```
 Environment="production"
 my_region="eastus"
 size ="Standard_DS2_v2"
 sku = "Standard_F2"
 Instances="3"
 default="3"
 minimum="3"
 Password="ChooseYourPassword"
```

 For Staging infrastructure write on the CLI:
```
% terraform workspace select Staging
% terraform apply -var-file=Staging.tfvars  
```
 You should use Staging.tfvars file with these variables (change the Password):
```
 Environment="staging"
 my_region="centralus"
 size ="Standard_D2ads_v5"
 sku = "Standard_D2ads_v5"
 Instances="2"
 default="2"
 minimum="2"
 Password="ChooseYourPassword"
```
## How to deploy

Once the infrastructure is provisioned, we will deploy the app by ansible.
In both production and staging environments we have created our ansible controler in 'AppServer-production' and 'AppServer-staging' resources groups.
1. Connect to the ansible controlers and install ansible. 
2. create ssh key and copy to remote machine.
3. Configure remote machine to enable ansible to run it by changing the file value (/etc/ssh/sshd_config) for pubkeyAuthentication to "yes" 

In the ansible controlers: 


```
% git clone https://github.com/GuyR53/AnsibleWeek6Code.git
```

Change the hosts in: inventories/prod/hosts and in inventories/stage/hosts to fit your nodes:
```
[stageservers]
10.0.0.6 ansible_ssh_user=adminuser
10.0.0.8 ansible_ssh_user=adminuser
```

```
[prodservers]
10.0.0.6 ansible_ssh_user=adminuser
10.0.0.7 ansible_ssh_user=adminuser
10.0.0.9 ansible_ssh_user=adminuser
```

Add new file prodservers.yml inside >> inventories/prod/group_vars/prodservers.yml with that content (Change the <> to your Value):

```
---
HOST_URL: http://<LoadBalancerIP>:8080
OKTAURL: https://<YourOktaDomain>
OKTAID: <YourOktaID>
OKTASECRET: <YourOktaSecret>
PGHOST: 10.0.1.4
PGUSERNAMEE: postgres
PGDBNAME: postgres
PGPASS: <YourPasswordFromAbove>
PGPORT: 5432
```

Add new file prodservers.yml inside >> inventories/stage/group_vars/stageservers.yml with that content  (Change the <> to your Value):

```
---
HOST_URL: http://<LoadBalancerIP>:8080
OKTAURL: https://<YourOktaDomain>
OKTAID: <YourOktaID>
OKTASECRET: <YourOktaSecret>
PGHOST: 10.0.1.4
PGUSERNAMEE: postgres
PGDBNAME: postgres
PGPASS: <YourPasswordFromAbove>
PGPORT: 5432
```
 
 then finish the deployment by:
 
 ```
 % cd AnsibleWeek6Code
 % ansible-playbook -v -i inventories/stage --extra-vars server_env_group="stageservers" main_playbook.yml
 % ansible-playbook -v -i inventories/prod --extra-vars server_env_group="prodservers" main_playbook.yml
```
You should get that result for prod (for staging same with 2 servers):
 
 
<img width="549" alt="Screen Shot 2022-04-02 at 16 13 07" src="https://user-images.githubusercontent.com/93793111/161385002-62b570d3-8d2e-45ce-8f2b-609d818b559a.png">

 

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
