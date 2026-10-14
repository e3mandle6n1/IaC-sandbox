param location string
param storageAccountName string
param storageAccountId string
param fileShareName string
param fileShareId string

resource vault 'Microsoft.RecoveryServices/vaults@2024-04-01' = {
  name: 'rsv-az104-rg7'
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    redundancySettings: {
      standardTierStorageRedundancy: 'GeoRedundant'
      crossRegionRestore: 'Disabled'
    }
  }
}

resource fileSharePolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-04-01' = {
  parent: vault
  name: 'DailyPolicy'
  properties: {
    backupManagementType: 'AzureStorage'
    workLoadType: 'AzureFileShare'
    timeZone: 'UTC'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2024-01-01T19:30:00Z'
      ]
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2024-01-01T19:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
  }
}

resource backupFabric 'Microsoft.RecoveryServices/vaults/backupFabrics@2024-04-01' = {
  parent: vault
  name: 'Azure'
}

resource protectionContainer 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers@2024-04-01' = {
  parent: backupFabric
  name: 'StorageContainer;Storage;${resourceGroup().name};${storageAccountName}'
  properties: {
    backupManagementType: 'AzureStorage'
    containerType: 'StorageContainer'
    friendlyName: storageAccountName
    sourceResourceId: storageAccountId
  }
}

resource protectedShare 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2024-04-01' = {
  parent: protectionContainer
  name: 'AzureFileShare;${fileShareName}'
  properties: {
    protectedItemType: 'AzureFileShareProtectedItem'
    policyId: fileSharePolicy.id
    sourceResourceId: fileShareId
  }
}
