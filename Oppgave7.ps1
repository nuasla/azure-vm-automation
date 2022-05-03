param(
    [string]$subId              = "d2f5f9de-13af-43fe-9bcf-7c82bd1390fd",
    [string[]]$rgListOfNames    = @("rgDemo1"; "rgDemo2")
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

foreach ($rgName in $rgListOfNames) {

    $name = "resourceGroup-$((New-Guid).Guid)"
    Write-Host "Preparing a new rg deployment - [$name] into [$subId]"

    $params = @{
        Name                        = $name
        Location                    = "norwayeast"
        TemplateFile                = "./rg.bicep"
        TemplateParameterObject     = @{rgName = $rgName }
    }
    New-AzDeployment @params

}

