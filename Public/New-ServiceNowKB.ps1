function New-ServiceNowKB {
    param (
        [Parameter(Mandatory=$True)]
        [String]$InstanceName,

        [Parameter(Mandatory=$True)]
        [pscredential]$Credential,

        [Parameter(Mandatory=$True)]
        [Alias('knowledge_base')]
        [ValidatePattern('[a-zA-Z0-9]{32}')]
        [String]$kb_knowledge_base,

        [Parameter(Mandatory=$True)]
        [Alias('category')]
        [String]$u_category,

        [Parameter(Mandatory=$True)]
        [Alias('application')]
        [ValidatePattern('[a-zA-Z0-9]{32}')]
        [String]$u_application,

        [Parameter(Mandatory=$True)]
        [ValidateLength(1,100)]
        [String]$short_description,

        [Parameter(Mandatory=$False)]
        [String]$text,

        [Parameter(Mandatory=$False)]
        [Alias('state')]
        [ValidateSet('wip','complete','validate','publish')]
        [String]$u_article_state = 'wip'
    )
    
    begin {
        $BaseUri = "https://$InstanceName.service-now.com/api/now/table/"
        $Endpoint = "kb_knowledge"
        [uri]$Uri = "$BaseUri$Endpoint"

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
        }
        if ($text) {
            $body.add('text',$text)
        }
        [byte[]]$bBody = [System.Text.Encoding]::UTF8.GetBytes( ($body | ConvertTo-Json -Compress) )

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
        Invoke-RestMethod @NewKBSplat
    }
}