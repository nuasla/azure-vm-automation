param(
    [string[]]$rgNames
)
# function/commando for creating a resource group

# NB!! Wich tenant/subscription
# You can use different browsers with different colors for different tenants
# Activate the right browswer, then do Connect-AzAccount

# How to define the correct subscription, in case of access to many

## ASSUMPTION - already logged in correct tenant

Set-AzContext -SubscriptionId <Name>

foreach ($rgName in $rgNames) {
    New-AzResourceGroup -Name $rgName -Location "norwayeast"
}

# After completion - remember Disconnect-AzAccount -Scope CurrentUser

