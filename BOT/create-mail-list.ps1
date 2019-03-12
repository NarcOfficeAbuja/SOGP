# Create mailing list for SOGP BOT

. "$PSScriptRoot/contactdetailsobject.ps1"

$town = @{
    abj = "Abuja"
    lag = "Lagos"
    ben = "Benin City"
}

$title = @{
    mr = "Mr"
    mrs = "Mrs"
    doc = "Dr"
    prof = "Prof"
    he = "His Excellency"
    sen = "Senator"
    pst = "Pastor"
    rev = "Reverend"
    apo = "Apostle"
}

$contactDetailsArray = @()
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'prof' `
                               -name "Jerry Gana" `
                               -address "18, Aso Drive, Asokoro" `
                               -location $town.'abj' 
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'doc' `
                               -name "Paul Adefarasin" `
                               -address "Rock Cathedral Drive, Lekki-Epe ExpressWay" `
                               -location $town.'lag'
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'doc' `
                               -name "Tony Rapu" `
                               -address "Freedom Way, End of Admiralty Way, Lekki Phase 1" `
                               -location $town.'lag' 
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'doc' `
                               -name "Pax Harry" `
                               -address "9 Lephalala Close, Maitama" `
                               -location $town.'abj' 
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'mr' `
                               -name "Stephen Oronsaye" `
                               -address "15, Bola Ige Close, Asokoro" `
                               -location $town.'abj' 
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'prof' `
                               -name "Yinka Omorogbe" `
                               -address "Edo State Ministry of Justice" `
                               -location "Benin City" `
                               -isFemale
$contactDetailsArray +=  New-ContactDetailsObject -title $title.'doc' `
                               -name "Chidi Odinkalu" `
                               -address $null `
                               -location $town.'abj' 
$contactDetailsArray +=  New-ContactDetailsObject -title "H.E. Senator" `
                               -name "Lyel Imoke" `
                               -address "27, Suleiman Barau Crescent, Aso Villa, Asokoro" `
                               -location $town.'abj' 

# Generate files
$contactDetailsArray | Export-Csv -Path "./bot-list.csv" -NoTypeInformation
$contactDetailsArray | ConvertTo-Json -Depth 1 | Set-Content -Path "./bot-list.json"
$contactDetailsArray | ConvertTo-Xml -Depth 1 -As String -NoTypeInformation | Set-Content -Path "./bot-list.xml"