Function Get-ServiceNowApplication {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$InstanceName,

        [Parameter(Mandatory=$True)]
        [PSCredential]$Credential,

        [Parameter()]
        [string]$Name
    )

    $BaseUri  = "https://$InstanceName.service-now.com/api/now/table/"
    $Endpoint = 'cmdb_ci_appl'
    [Uri]$Uri = "$BaseUri$Endpoint"
    $KBInvokeSplat = @{
        'Uri'        = $Uri 
        'Method'     = 'Get'
        'Credential' = $Credential 
        'Headers'    = @{"accept"="application/json"}
    }


    $Result = Invoke-RestMethod @KBInvokeSplat
    
    $Out = $Result.result

    If ($Name) {
        $Out = $Out.Where({$_.Name -like "*$Name*"})
    }

    $Out
}