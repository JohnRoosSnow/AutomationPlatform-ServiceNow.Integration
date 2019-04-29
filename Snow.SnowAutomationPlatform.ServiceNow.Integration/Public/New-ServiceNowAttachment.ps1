function New-ServiceNowAttachment {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$InstanceName,

        [Parameter(Mandatory=$True)]
        [PSCredential]$Credential,

        [Parameter(Mandatory=$True)]
        [Alias('Attachment')]
        [ValidateScript({ (Test-Path -Path $_) -and ([System.IO.Path]::IsPathRooted($_)) })]
        [string]$Path,

        [Parameter(Mandatory=$True)]
        [Alias('TableName')]
        [string]$table_name,

        [Parameter(Mandatory=$True)]
        [Alias('TableSysId')]
        [ValidateScript({ $_.Length -eq 32 })]
        [string]$table_sys_id
    )

    begin {
        $FileObject = Get-Item -Path $Path
        
        $UriQuery = "?table_name=$table_name&table_sys_id=$table_sys_id&file_name=$($FileObject.Name)"
        $BaseUri  = "https://$InstanceName.service-now.com/api/now/"
        $Endpoint = 'attachment/file'
        [uri]$Uri = "$BaseUri$Endpoint$UriQuery"

        [byte[]]$AttachmentAsBytes = [System.IO.File]::ReadAllBytes($path)

        # This list is by no means complete, or even that good. Check https://www.iana.org/assignments/media-types/media-types.xhtml for reference
        $ContentType = switch ($FileObject.Extension) {
            '.png'  { 'image/png' }
            '.jpg'  { 'image/jpeg' }
            '.gif'  { 'image/gif' }
            '.tiff' { 'image/tiff' }
            '.pdf'  { 'application/pdf' }
            '.Zip'  { 'application/zip' }
            '.mov'  { 'video/quicktime' }
            '.mp4'  { 'video/mp4' }
            '.mpg'  { 'video/mpeg' }
            '.mpeg' { 'video/mpeg' }
            Default { 'application/octet-stream' }
        }

        $NewAttachmentSplat = @{
            'Uri' = $Uri
            'Credential' = $Credential
            'Method' = 'Post'
            'Body' = $AttachmentAsBytes
            'ContentType' = $ContentType
        }
    }

    process {

    }

    end {
        Invoke-RestMethod @NewAttachmentSplat
    }
}
