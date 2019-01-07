function Add-AuvikBaseURI {
    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeline)]
        [Alias('Email')]
        [string]$BaseURI = 'https://auvikapi.us1.my.auvik.com',

        [Alias('locale','dc')]
        [ValidateSet( 'US1', 'US2', 'EU1', 'EU2', 'AU1')]
        [String]$data_center = ''
    )

    # Trim superflous forward slash from address (if applicable)
    if($BaseURI[$BaseURI.Length-1] -eq "/") {
        $BaseURI = $BaseURI.Substring(0,$BaseURI.Length-1)
    }

    switch ($data_center) {
        'US1' {$BaseURI = 'https://auvikapi.us1.my.auvik.com'}
        'US2' {$BaseURI = 'https://auvikapi.us2.my.auvik.com'}

        'EU1' {$BaseURI = 'https://auvikapi.eu1.my.auvik.com'}
        'EU2' {$BaseURI = 'https://auvikapi.eu2.my.auvik.com'}
        
        'AU1' {$BaseURI = 'https://auvikapi.au1.my.auvik.com'}
        Default
        {
            # Hitting the top level app (without specifying the cluster) should also redirect to the appropriate cluster with an HTTP 308
            $BaseURI = "https://auvikapi.my.auvik.com"}
        }
    }

    Set-Variable -Name "Auvik_Base_URI" -Value $BaseURI -Option ReadOnly -Scope global -Force
}

function Remove-AuvikBaseURI {
    Remove-Variable -Name "Auvik_Base_URI" -Scope global -Force 
}

function Get-AuvikBaseURI {
    return $Auvik_Base_URI
}

New-Alias -Name Set-AuvikBaseURI -Value Add-AuvikBaseURI
