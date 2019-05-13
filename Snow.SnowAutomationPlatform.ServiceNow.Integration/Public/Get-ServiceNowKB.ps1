function Get-ServiceNowKB {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$InstanceName,

        [Parameter(Mandatory=$True)]
        [PSCredential]$Credential,

        [Parameter(Mandatory=$True)]
        [ValidateSet('number','text','display_number','short_description','sys_id','meta')]
        [string]$QueryParameter,

        [Parameter(Mandatory=$True)]
        [string]$QueryValue,

        [Parameter(Mandatory=$True)]
        [ValidateSet('=','LIKE')]
        [string]$QueryOperator,

        [Parameter()]
        [UInt32]$Limit = 1
    )

    begin {
        $KBQuery = "sysparm_query=$QueryParameter$QueryOperator$QueryValue".ToLower()
        $KBLimit = "sysparm_limit=$Limit"

        $BaseUri  = "https://$InstanceName.service-now.com/api/now/table/"
        $Endpoint = 'kb_knowledge'

        [Uri]$Uri = "$BaseUri$Endpoint`?$KBLimit&$KBQuery"
        
        $KBInvokeSplat = @{
            'Uri' = $Uri
            'Method' = 'Get'
            'Credential' = $Credential
            'Headers'    = @{"accept"="application/json"}
        }
    }
    process {

    }
    end {
        $Result = Invoke-RestMethod @KBInvokeSplat
    
        $Out = $Result.result
    
        $Out
    }
}