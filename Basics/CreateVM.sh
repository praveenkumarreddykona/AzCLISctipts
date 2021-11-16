#! /bin/bash
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
read -s password

az vm create -n testvm01 -l eastus2 -g AzLearnRG-01 --size $size --admin-username $username --admin-password $password --image $image