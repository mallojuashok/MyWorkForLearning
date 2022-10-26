#!/bin/bash  

az group create --location centralus --resource-group FromClI


az network vnet create --name 'CliVN' --resource-group 'FromClI' --address-prefixes '10.10.0.0/16' --location 'centralus'



az network vnet subnet create --address-prefixes '10.10.0.0/24' --name 'webcli' --resource-group 'FromClI' --vnet-name 'CliVN'


az network nsg create --name 'Myinetrnal' --resource-group 'FromClI' --location 'centralus'
                

az network nsg rule create --name 'MyNsg' --nsg-name 'Myinetrnal' --priority 500 --resource-group 'FromClI' --access 'Allow' --protocol 'Tcp' --direction 'Inbound' --source-port-ranges 22  --source-address-prefixes *
            
           
az vm create --name 'MyVmCli' --resource-group 'FromClI' --admin-password devops@123456 --admin-username devops --authentication-type 'password' --image 'UbuntuLTS' --location 'centralus' --nsg 'MyNsg' --size 'Standard_B1s' --public-ip-sku 'Basic' --subnet 'webcli' --vnet-name 'CliVN'
             
             

