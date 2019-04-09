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
        [string]$Text,
        
        [Parameter(Mandatory=$True,
            ParameterSetName='Field'
        )]
        [ValidateScript({ $_ -match '[a-zA-Z0-9]{32}' })]
        [string]$sys_id
    )
    
    begin {
        switch ($PSCmdlet.ParameterSetName) {
            'Object' { 
                [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ($ServiceNowObject | ConvertTo-Json -Compress) ) 
                $sysid = $ServiceNowObject.Sys_id
            }
            'Field' { 
                [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ([psobject]@{$Field=$Text} | ConvertTo-Json -Compress)) 
                $sysid = $sys_id
            }
        }
        
        $BaseUri = "https://$InstanceName.service-now.com/api/now/table/"
        $Endpoint = "kb_knowledge/$sysid"
        [uri]$Uri = "$BaseUri$Endpoint"


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