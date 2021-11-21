#! /bin/bash

#create vNet
az network vnet create --name vnet-1-24 --resource-group AzLearnRG-01 -l eastus --address-prefix 10.1.1.0/24 --subnet-name vnsub-01-1-24 --subnet-prefix 10.1.1.0/25 --nsg vnsg-01 --flowtimeout 4m 

#creatng additional subnet
az network vnet subnet create --name vnsub-02-dmz --address-prefix 10.1.1.128/26 --vnet-name vnet-1-24
#creation subnet for bastion use
az network vnet subnet create --name AzureBastionSubnet --address-prefix 10.1.1.192/27 --vnet-name vnet-1-24

#creatinga  public ip for bastion
az network public-ip create --name vnet01bastion-pip --resource-group AzLearnRG-01 --location eastus --sku Standard --allocation-method static

#creating bastion host 
az network bastion create --location eastus --name vnet-1-24bastion --resource-group AzLearnRG-01 --public-ip-address vnet01bastion-pip --vnet-name vnet-1-24 --sku Standard