param(
    [string]$rgName = "Numan",
    [string]$vmName = "VM1",
    [string]$vmUser = "testbruker",
    [string]$vmPassword 
)


#Connect-AzAccount
#Husk å være logget inn.

#Sett aktiv subscription til Lærling Sandbox. 
Set-AzContext "d2f5f9de-13af-43fe-9bcf-7c82bd1390fd"

Get-AzResourceGroup -Name $rgName -ErrorVariable rgnotPresent -ErrorAction SilentlyContinue | out-null
if ($rgnotPresent) {
    # ResourceGroup doesn't exist
    Write-host "Ressursgruppen $rgName finnes ikke. Oppretter den..."
    New-AzResourceGroup -Name $rgName -Location norwayeast -force 
} else {
    # ResourceGroup exist
    write-host "Ressursgruppen $rgName finnes"
}


Get-AzVM -Name $vmName -ErrorVariable vmnotPresent -ErrorAction SilentlyContinue -ResourceGroupName $rgName | out-null
if ($vmnotPresent) {     
    # VirtualMachine doesn't exist
    Write-host "Virtuell maskin $vmName finnes ikke. Oppretter den..."
    $password = ConvertTo-SecureString $vmPassword -AsPlainText -Force
    $Cred = New-Object System.Management.Automation.PSCredential ($vmUser, $password)
    New-AzVM -Name $vmName -Location "NorwayEast" -ResourceGroupName $rgName -Image "Win2019Datacenter" -Credential $Cred
} else {
    # VirtualMachine exist
    write-host "Virtuell Maskin $vmName finnes"
}

