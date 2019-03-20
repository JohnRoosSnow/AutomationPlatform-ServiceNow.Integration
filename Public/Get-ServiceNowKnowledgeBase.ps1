Function Get-ServiceNowKnowledgeBase {
    [CmdLetBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [String]$InstanceName,

        [Parameter(Mandatory=$True)]
        [pscredential]$Credential
    )
    

    $BaseUri  = "https://$InstanceName.service-now.com/api/now/table/"
    $Endpoint = 'kb_knowledge_base'
    [Uri]$Uri = "$BaseUri$Endpoint"
    $KBInvokeSplat = @{
        'Uri'        = $Uri 
        'Method'     = 'Get'
        'Credential' = $Credential 
        'Headers'    = @{"accept"="application/json"}
    }


    $Result = Invoke-RestMethod @KBInvokeSplat
    
    $Out = $Result.result

    $Out
}