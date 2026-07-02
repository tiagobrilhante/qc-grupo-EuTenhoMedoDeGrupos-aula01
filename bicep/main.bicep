@description('Região dos recursos')
param location string = resourceGroup().location

@description('Tamanho da VM')
param vmSize string = 'Standard_D2s_v3'

@description('Usuário administrador da VM')
param adminUsername string = 'azureuser'

@description('Chave pública SSH (conteúdo do arquivo .pub)')
@secure()
param adminPublicKey string

@description('IP público de origem autorizado a conectar via SSH, sem a máscara /32')
param meuIp string

var tags = {
  aula: '1'
  disciplina: 'cloud-cognitive'
  provisionado: 'bicep'
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'vm-lab-aula01-vnet'
  location: location
  tags: tags
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
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        // Exercício 3.1 / 3.2: subnet dedicada à futura camada de aplicação da QC
        name: 'subnet-app'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'vm-lab-aula01-nsg'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '${meuIp}/32'
          destinationAddressPrefix: '*'
        }
      }
      // EXTRA (hardening do grupo): HTTPS também restrito a meuIp, não aberto a '*'.
      {
        name: 'HTTPS'
        properties: {
          priority: 320
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '${meuIp}/32'
          destinationAddressPrefix: '*'
        }
      }
      // EXTRA (hardening do grupo): HTTP também restrito a meuIp, não aberto a '*'.
      {
        name: 'HTTP'
        properties: {
          priority: 340
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '${meuIp}/32'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource pip 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'vm-lab-aula01-ip'
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'vm-lab-aula01-nic'
  location: location
  tags: tags
  properties: {
    enableAcceleratedNetworking: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'vm-lab-aula01'
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'vm-lab-aula01'
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: adminPublicKey
            }
          ]
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

@description('IP público da VM')
output publicIpAddress string = pip.properties.ipAddress
