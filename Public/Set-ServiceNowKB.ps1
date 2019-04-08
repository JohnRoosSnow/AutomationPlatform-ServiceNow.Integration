function Set-ServiceNowKB {
    [CmdletBinding(DefaultParameterSetName='Object')]
    param (
        [Parameter(Mandatory=$True)]
        [String]$InstanceName,

        [Parameter(Mandatory=$True)]
        [pscredential]$Credential,

        [Parameter(Mandatory=$True,
            ParameterSetName='Object'
        )]
        [ValidateScript({ 
            If ( $_.Sys_id -match '[a-zA-Z0-9]{32}' ) {
                $True
            }
            else {
                $False
            }
        })]
        [psobject]$ServiceNowObject,

        [Parameter(Mandatory=$True,
            ParameterSetName='Field'
        )]
        [string]$Field,
        
        [Parameter(Mandatory=$True,
            ParameterSetName='Field'
        )]
        [string]$Text
    )
    
    begin {
        $BaseUri = "https://$InstanceName.service-now.com/api/now/table/"
        $Endpoint = "kb_knowledge/$($ServiceNowObject.Sys_id)"
        [uri]$Uri = "$BaseUri$Endpoint"

        switch ($PSCmdlet.ParameterSetName) {
            'Object' { [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ($ServiceNowObject | ConvertTo-Json -Compress) ) }
            'Field' { [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ([psobject]@{$Field=$Text} | ConvertTo-Json -Compress)) }
        }
        

        $SetKBSplat = @{
            'uri' = $Uri
            'method' = 'Put'
            'Credential' = $Credential 
            'Headers' = @{"accept"="application/json"} 
            'ContentType' = 'application/json'
            'Body' = $bBody
        }
    }
    process {

    }
    end {
        Invoke-RestMethod @SetKBSplat
    }
}