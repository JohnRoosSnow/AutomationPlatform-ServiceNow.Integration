function Set-ServiceNowKB {
    param (
        [Parameter(Mandatory=$True)]
        [String]$InstanceName,

        [Parameter(Mandatory=$True)]
        [pscredential]$Credential,

        [Parameter(Mandatory=$True)]
        [ValidateScript({ 
            If ( $_.Sys_id -match '[a-zA-Z0-9]{32}' ) {
                $True
            }
            else {
                $False
            }
        })]
        [psobject]$ServiceNowObject
    )
    
    begin {
        $BaseUri = "https://$InstanceName.service-now.com/api/now/table/"
        $Endpoint = "kb_knowledge/$($ServiceNowObject.Sys_id)"
        [uri]$Uri = "$BaseUri$Endpoint"

        [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ($ServiceNowObject | ConvertTo-Json -Compress) )

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