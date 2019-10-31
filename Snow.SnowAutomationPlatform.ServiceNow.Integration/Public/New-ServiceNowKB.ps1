function New-ServiceNowKB {
    param (
        [Parameter(Mandatory=$True,
                   ParameterSetName='default')]
        [Parameter(Mandatory=$True,
                   ParameterSetName='object')]
        [String]$InstanceName,

        [Parameter(Mandatory=$True,
                   ParameterSetName='default')]
        [Parameter(Mandatory=$True,
                   ParameterSetName='object')]
        [pscredential]$Credential,

        [Parameter(Mandatory=$True,
                   ParameterSetName='default')]
        [Alias('knowledge_base')]
        [ValidatePattern('[a-zA-Z0-9]{32}')]
        [String]$kb_knowledge_base,

        [Parameter(Mandatory=$True,
                   ParameterSetName='default')]
        [Alias('category')]
        [String]$u_category,

        [Parameter(Mandatory=$True,
                   ParameterSetName='default')]
        [Alias('application')]
        [ValidatePattern('[a-zA-Z0-9]{32}')]
        [String]$u_application,

        [Parameter(Mandatory=$True,
                   ParameterSetName='default')]
        [ValidateLength(1,100)]
        [String]$short_description,

        [Parameter(Mandatory=$False,
                   ParameterSetName='default')]
        [String]$text,

        [Parameter(Mandatory=$False,
                   ParameterSetName='default')]
        [Alias('state')]
        [ValidateSet('wip','complete','validate','publish')]
        [String]$u_article_state = 'wip',
        
        [Parameter(Mandatory=$False,
                   ParameterSetName='default')]
        [ValidateSet('draft','review','published')]
        [String]$workflow_state = 'published',
        
        
        [Parameter(Mandatory=$True,
                   ParameterSetName='object')]
        [psobject]$InputObject
    )
    
    begin {
        
        switch ($PSCmdlet.ParameterSetName) 
        {
            'default' 
            { 
                [Int]$iState = switch ($u_article_state) {
                    'wip' { 1 }
                    'complete' { 2 }
                    'validate' { 3 }
                    'publish' { 4 }
                    'default' { 1 }
                }

                $body = [psobject]@{
                    'kb_knowledge_base' = $kb_knowledge_base
                    'u_category'        = $u_category
                    'u_application'     = $u_application
                    'short_description' = $short_description
                    'u_article_state'   = $iState
                    'workflow_state'    = $workflow_state
                }
                
                [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ($body | ConvertTo-Json -Compress) )
            }
            'object' 
            { 
                [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ($InputObject | ConvertTo-Json -Compress) )
            }
        }
        
        $BaseUri = "https://$InstanceName.service-now.com/api/now/table/"
        $Endpoint = "kb_knowledge"
        [uri]$Uri = "$BaseUri$Endpoint"

        $NewKBSplat = @{
            'uri' = $Uri
            'method' = 'Post'
            'Credential' = $Credential 
            'Headers' = @{"accept"="application/json"} 
            'ContentType' = 'application/json'
            'Body' = $bBody
        }
    }
    process {

    }
    end {
        # PowerShell 5.0 and earlier uses TLS 1.0 as default. We dont want that.
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls
        Invoke-RestMethod @NewKBSplat
    }
}