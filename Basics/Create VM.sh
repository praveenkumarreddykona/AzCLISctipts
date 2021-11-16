#! /bin/bash

az vm list-sizes -l eastus2 -o table | grep B
az vm create -n testvm01 -l eastus2 -g AzLearnRG-01 --size Standard_B2ms --admin-username sysadm --admin-password "Password" --image MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest