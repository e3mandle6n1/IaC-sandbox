param location string

// Spoke: application virtual network (frontend + backend)
resource appVnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'app-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'frontend'
        properties: {
          addressPrefixes: [
            '10.1.0.0/24'
          ]
        }
      }
      {
        name: 'backend'
        properties: {
          addressPrefixes: [
            '10.1.1.0/24'
          ]
        }
      }
    ]
  }
}

// Hub: firewall virtual network
resource hubVnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'hub-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        // Required exact name for Azure Firewall
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefixes: [
            '10.0.0.0/26'
          ]
        }
      }
    ]
  }
}

// Peering names match the lab portal form when creating from app-vnet:
// Local (on app-vnet) = hub-to-app-vnet
// Remote (on hub-vnet) = app-vnet-to-hub
resource appToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  parent: appVnet
  name: 'hub-to-app-vnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnet.id
    }
  }
}

resource hubToApp 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  parent: hubVnet
  name: 'app-vnet-to-hub'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: appVnet.id
    }
  }
}

output appVnetId string = appVnet.id
output hubVnetId string = hubVnet.id
output frontendSubnetId string = appVnet.properties.subnets[0].id
output backendSubnetId string = appVnet.properties.subnets[1].id
output azureFirewallSubnetId string = hubVnet.properties.subnets[0].id
