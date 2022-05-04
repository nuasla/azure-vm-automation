param virtualMachines_MyVm_name string = 'NumanVm'
param virtualNetworks_MyVm_name string = 'NumanVnet'
param networkInterfaces_MyVm_name string = '${virtualMachines_MyVm_name}-NIC'
param networkSecurityGroups_MyVm_name string = '${virtualMachines_MyVm_name}-NSG'
param Location string = 'norwayeast'
param vmAdminName string = 'NumanAdmin'
@secure()
param vmAdminPassword string

resource networkSecurityGroups_MyVm_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_MyVm_name
  location: Location
  properties: {
    securityRules: [
      {
        name: '${networkSecurityGroups_MyVm_name}3389'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: '${networkSecurityGroups_MyVm_name}5985'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '5985'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1001
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource virtualNetworks_MyVm_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_MyVm_name
  location: Location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.0.0/16'
      ]
    }
    subnets: [
      {
        name: virtualNetworks_MyVm_name
        properties: {
          addressPrefix: '192.168.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualMachines_MyVm_name_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: virtualMachines_MyVm_name
  location: Location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_MyVm_name}_OsDisk_1_9dca4766b4834904a37edcf6cb1bf025'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          //id: resourceId('Microsoft.Compute/disks', '${virtualMachines_MyVm_name}_OsDisk_1_9dca4766b4834904a37edcf6cb1bf025')
        }
        deleteOption: 'Detach'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_MyVm_name
      adminUsername: vmAdminName
      adminPassword: vmAdminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        } 
      }
      secrets: []
      allowExtensionOperations: true
      //requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_MyVm_name_resource.id
        }
      ]
    }
  }
}

resource networkSecurityGroups_MyVm_name_networkSecurityGroups_MyVm_name_3389 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_MyVm_name_resource
  name: '${networkSecurityGroups_MyVm_name}3389'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1000
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_MyVm_name_networkSecurityGroups_MyVm_name_5985 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_MyVm_name_resource
  name: '${networkSecurityGroups_MyVm_name}5985'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '5985'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1001
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource virtualNetworks_MyVm_name_virtualNetworks_MyVm_name 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_MyVm_name_resource
  name: virtualNetworks_MyVm_name
  properties: {
    addressPrefix: '192.168.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource networkInterfaces_MyVm_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_MyVm_name
  location: Location
  properties: {
    ipConfigurations: [
      {
        name: networkInterfaces_MyVm_name
        properties: {
          privateIPAddress: '192.168.1.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_MyVm_name_virtualNetworks_MyVm_name.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    networkSecurityGroup: {
      id: networkSecurityGroups_MyVm_name_resource.id
    }
  }
}
