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
        [UInt32]$Limit = 1,
        
        [Parameter()]
        [ValidateSet('published','draft')]
        [string]$workflow_state
        
    )

    begin {
        $QueryParameter = $QueryParameter.ToLower()
        $KBQuery = "sysparm_query=$QueryParameter$QueryOperator$QueryValue"
        if ($workflow_state) {
          $KBQuery = "$KBQuery&workflow_state=$workflow_state"
        }
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
        # PowerShell 5.0 and earlier uses TLS 1.0 as default. We dont want that.
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls
        $Result = Invoke-RestMethod @KBInvokeSplat
        $Out = $Result.result
        $Out
    }
}
