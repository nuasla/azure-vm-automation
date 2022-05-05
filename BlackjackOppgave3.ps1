# Feilhåndtering - stopp programmet hvis det dukker opp noen feil

$ErrorActionPreference = 'Stop'


$webRequest = Invoke-WebRequest -Uri 'http://nav-deckofcards.herokuapp.com/shuffle'

$kortstokkJson = $webRequest.Content

$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson <#en string som innholder json#>

# å skrive ut kortene i kortstokken er form for loop/iterere oppgave
# 1. utgave - foreach loop som skriver ut et kort per linje
foreach ($kort in $kortstokk) {
    Write-Output $kort
}

# En streng (string) er en array av karakterer @('S','P','A','D','E')
# 2. utgave - interessert i 1. karakter i merke - (S)PADE - og verdi
$string = ""
foreach ($kort in $kortstokk) {
    $string = $string + "$($kort.suit[0])$($kort.value),"
}
Write-Output $string
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.1#subexpression-operator--


# 3. utgave - ønsker egentlig hele kortstokken som en streng og den koden som en funksjon (gjenbruk)

function kortstokkTilStreng {
    [OutputType([string])]
    param (
        [object[]]
        $kortstokk
    )
    $streng = ""
    foreach ($kort in $kortstokk) {
        $streng = $streng + "$($kort.suit[0])$($kort.value),"
    }
    return $streng
}


Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"

# hvorfor kommer det et komma ',' etter siste kort?
# frivillig oppgave - kan du forbedre funksjonen 'kortTilStreng' - ikke skrive ut komma etter siste kort?