param location string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
    ]
  }
}

output defaultSubnetId string = vnet.properties.subnets[0].id
