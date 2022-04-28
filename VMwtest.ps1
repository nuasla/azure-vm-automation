param(
    [string]$rgName = "Numan"
)

#Connect-AzAccount
#Husk å være logget inn.

#Sett aktiv subscription til Lærling Sandbox. 
Set-AzContext "d2f5f9de-13af-43fe-9bcf-7c82bd1390fd"

Get-AzResourceGroup -Name $rgName -ErrorVariable notPresent -ErrorAction SilentlyContinue

if ($notPresent)
{
    # ResourceGroup doesn't exist
    New-AzResourceGroup -Name $rgName -Location norwayeast -force 
}
else
{
    # ResourceGroup exist
}

