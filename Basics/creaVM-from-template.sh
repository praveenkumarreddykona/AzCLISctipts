#! /bin/bash

# get the subscription ID
sub=az account list --query '[?contains(name, 'Contoso')].id'

#set the subscription to deploy resources into

#set by subscription ID

az account set --subscription $sub

##-----------OR---------------- by subscription name
#az account -set --subscription "name of the subscription"

templateName= './azuredeploy.json'
date=$(date "+%d-%m-%Y")
deplymentName='template-1-'$date

az deployment group create -n $deploymentName --template-file $templateName


