function  New-ContactDetailsObject
{
<#
.SYNOPSIS
    Create a PSCustomObject of Contact details.
.DESCRIPTION
    This function takes a number of arguments representing the various data fields.
    It also has an optional parameter to indicate whether the subject is female or not.
    There are some conditionals that help to determine the value of the "salutation" field.
.PARAMETER title
    The person's courtesy title.
.PARAMETER name
    The persons full name.
.PARAMETER address
    The person's postal address.
.PARAMETER location
    The town or city where the person lives.
.PARAMETER isFemale
    Whether the person is female (Optional parameter)
.EXAMPLE
    New-ContactDetailsObject -title "Mrs" -name "Jane Taylaur" -address "6, Tapgun Drive" -location "Abuja"  
.NOTES
    Author: Victor Ordu
    Last Edit: 2019-03-11
    Version 1.0 - initial release
#>
    param(
        $title = $null,
        $name = $null,
        $address = $null,
        $location = $null,
        [Parameter(Mandatory=$false)]
        [switch]$isFemale = $false
    )

    # Deduce salutations for use in mail
    if ($title -like "*H.E.*" -or $title -like "*Excellency*") {
        $salutation = "Your Excellency"
    } else {
        if ($isFemale) {
            $salutation = "Ma"
        } else {
            $salutation = "Sir"
        }
    }

    [PSCustomObject]@{
        name = "$title $name"
        address = $address
        location = $location
        salutation = $salutation
    }
}