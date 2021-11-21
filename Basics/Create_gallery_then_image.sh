#! /bin/bash

#list all subscriptions you have. below command will show the list of subscriptions with IDs
az account list -o table

#As I have a subscription in my tenant I want to set the subscription for further actions
az account set --subscription <subscription name/id>

#list all resource groups you have in the subscription
#az group list --subscription <subscription ID> -o table
#___OR___
# list all the resource groups of the subscription we set above for future actions
az group list -o table

#create a gallery on teh resourec group 
az sig create --gallery-name Imagegallery --location eastus2 --resources-group AzLearnRG-01

#list all VMs 
az vm list -o table

#list al lthe vms of type Windows/Linux
az vm list --resource-group AzLearnRG-01 --query '[?osProfile.osDisk.osType=='Linux'].{Id: vmId, Name: name, ResourceGroup: resourceGroup, Size: hardwareProfile.vmSize, Location: location, Os: storageProfile.osDisk.osType,State: statuses.dusplayStatus, OSVersion: storageProfile.imageReference.sku}' -o table

#get vm ID
az vm get-instance-view --resource-group AzLearnRG-01 --name test-vm-01 --query id 

#choose the Vm and generalize it
az vm generalize --resource-group AzLearnRG-01 --name test-vm-01

#create a managed image from the vm
az image create -g AzLearnRG-01 -l eastus -n testImage --os-type Windows --source vmname

#create Image Definition for Shared Image gallery
Az sig image-definition create --resource AzLearnRG-01 




az vm create --name test4mimage-01 --resource-group AzLearnRG-01 --image testImage --location eastus --size Standard_B2ms --admin-username sysadm --admin-password abcdef@123456 --vnet-name vnet-1-24 --subnet vnsub-01-1-24 --public-ip-address ""