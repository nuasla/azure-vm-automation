[CmdletBinding()]
param (
    # parameter er ikke obligatorisk siden vi har default verdi
    [Parameter(HelpMessage = "http://nav-deckofcards.herokuapp.com/shuffle", Mandatory = $false)]
    [string]
    # når paramater ikke er gitt brukes default verdi
    $UrlKortstokk = 'http://nav-deckofcards.herokuapp.com/shuffle'
)

$ErrorActionPreference = 'Stop'


$webRequest = Invoke-WebRequest -Uri $UrlKortstokk

$kortstokkJson = $webRequest.Content

$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson #en string som innholder json


$string = ""
foreach ($kort in $kortstokk) {
    $string = $string + "$($kort.suit[0])$($kort.value),"
}

Write-Output "Kortstokk:" $string






