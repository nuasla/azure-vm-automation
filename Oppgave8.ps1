param(
    [string]$subId       = "d2f5f9de-13af-43fe-9bcf-7c82bd1390fd",
    [string]$rgName      = "az-vm-auto-numan",
    [string]$vmName      = "NumanVm", 
    [string]$vmAdminName = "NumanAdmin",
    [securestring]$vmAdminPwd

)

$ErrorActionPreference = 'Stop'

$ctx = Get-AzContext


if ($null -eq $ctx) {
    Write-Warning "No user logged in - leaving program"
    exit 1 
}

try {
    Set-AzContext -SubscriptionId $subId
}
catch {
    Write-Warning "Cannot set active subscription - $subId"
    exit 1
}

    $params = @{
        Name                        = "vm-$((Get-Date -Format yyyyMMdd-HHmmss).ToString())"
        TemplateFile                = "./template.bicep"
        virtualMachines_MyVm_name   = $vmName
        vmAdminPassword             = $vmAdminPwd
        vmAdminName                 = $vmAdminName
        ResourceGroup               = $rgName
        
    }
    
New-AzResourceGroupDeployment @params
    



