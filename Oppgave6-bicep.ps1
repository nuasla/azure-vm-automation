param(
    [string[]]$rgListOfNames = @("rgDemo1";"rgDemo2")
)
# function/commando for creating a resource group

# NB!! Wich tenant/subscription
# You can use different browsers with different colors for different tenants
# Activate the right browswer, then do Connect-AzAccount

# How to define the correct subscription, in case of access to many

## ASSUMPTION - already logged in correct tenant

Set-AzContext -SubscriptionId "d2f5f9de-13af-43fe-9bcf-7c82bd1390fd"

foreach ($rgName in $rgListOfNames) {
    New-AzDeployment -Name "Deployment1-$rgName" -Location "norwayeast" -TemplateFile "./rg.bicep" -TemplateParameterObject @{rgName = $rgName}
    Write-Host "Jeg deployer-$rgName"
    #New-AzResourceGroup -Name $rgName -Location "norwayeast"
}

# After completion - remember Disconnect-AzAccount -Scope CurrentUser

