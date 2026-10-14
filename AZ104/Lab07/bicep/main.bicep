targetScope = 'subscription'

param location string = 'southafricanorth'
param resourceGroupName string = 'az104-rg7'
param storageAccountName string
param clientIpAddress string
param dataPlanePrincipalId string

resource lab 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module network 'modules/network.bicep' = {
  name: 'network'
  scope: lab
  params: {
    location: location
  }
}

module storage 'modules/storage.bicep' = {
  name: 'storage'
  scope: lab
  params: {
    location: location
    storageAccountName: storageAccountName
    clientIpAddress: clientIpAddress
    dataPlanePrincipalId: dataPlanePrincipalId
    allowedSubnetId: network.outputs.defaultSubnetId
  }
}

module backup 'modules/backup.bicep' = {
  name: 'backup'
  scope: lab
  params: {
    location: location
    storageAccountName: storageAccountName
    storageAccountId: storage.outputs.storageAccountId
    fileShareName: storage.outputs.fileShareName
    fileShareId: storage.outputs.fileShareId
  }
}

output storageAccountName string = storage.outputs.storageAccountName
output defaultSubnetId string = network.outputs.defaultSubnetId
