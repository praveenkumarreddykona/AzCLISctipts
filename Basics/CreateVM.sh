#! /bin/bash
az account list-locations -o table
echo 'Enter Region'
read region
echo 'Enter VM name'
read name
echo 'Enter what size you you want to deploy the vM'
read sizequery
az vm list-sizes -l eastus2 -o table | grep $sizequery
echo 'Enter the size selected'
read size
az vm image list -o table
echo 'Enter the size selected'
read image
echo -n 'Enter username'
read username
echo -n 'Enter Password'
read password

az vm create -n $name -l $region -g AzLearnRG-01 --size $size --admin-username $username --admin-password $password --image $image