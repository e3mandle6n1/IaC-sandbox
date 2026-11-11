targetScope = 'subscription'

@description('Azure region for all resources.')
param location string

@description('Resource group for the hub and spoke virtual networks.')
param resourceGroupName string

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module network 'modules/network.bicep' = {
  name: 'virtual-networks'
  scope: rg
  params: {
    location: location
  }
}

output appVnetId string = network.outputs.appVnetId
output hubVnetId string = network.outputs.hubVnetId
output frontendSubnetId string = network.outputs.frontendSubnetId
output backendSubnetId string = network.outputs.backendSubnetId
output azureFirewallSubnetId string = network.outputs.azureFirewallSubnetId
