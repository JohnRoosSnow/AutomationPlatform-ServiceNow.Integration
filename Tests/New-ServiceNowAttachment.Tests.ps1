$FunctionName = 'New-ServiceNowAttachment'
$ModuleRoot = "$PSScriptRoot\..\Snow.SnowAutomationPlatform.ServiceNow.Integration"

Describe 'Import function tests' -Tag 'PreBuild' {
    It 'Function should not be loaded' {
        Remove-Item Function:\$FunctionName -Force -ErrorAction SilentlyContinue
        { Get-Command $FunctionName -ErrorAction Stop } | Should -Throw
    }
    It 'Function should load when dot sourcing file' {
        . $ModuleRoot\Public\$($FunctionName).ps1
        (Get-Command $FunctionName).Name | Should -Be $FunctionName
    }
}

. $ModuleRoot\Public\$($FunctionName).ps1

Describe 'Parameters' {
    $ActualParameters = (Get-Command $FunctionName).Parameters
    $TestCases = @(
        @{
            'ParamName' = 'InstanceName'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'Credential'
            'ParamType' = 'PSCredential'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'Path'
            'ParamType' = 'string'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'table_name'
            'ParamType' = 'string'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'table_sys_id'
            'ParamType' = 'string'
            'Mandatory' = 'True'
        }
    )

    it '<ParamName> should exist' -TestCases $TestCases {
        Param(
            $ParamName
        )
        $ActualParameters.Keys.Contains($ParamName) | Should -BeTrue
    }
    it '<ParamName> should be of type <ParamType>' -TestCases $TestCases {
        Param(
            $ParamName,
            $ParamType
        )

        $ActualParameters[$ParamName].ParameterType.Name | Should -Be $ParamType
    }
    it '<ParamName> Mandatory should be <Mandatory>' -TestCases $TestCases {
        Param(
            $ParamName,
            $Mandatory
        )
        
        $ActualParameters[$ParamName].ParameterSets.Values.IsMandatory | Should -Be $Mandatory
    }
}

Describe 'create new attachment' {
    mock -CommandName Invoke-RestMethod -MockWith {
        return $NewAttachmentSplat
    } -Verifiable

    $DummyCreds = New-Object System.Management.Automation.PSCredential('DummyUser', ("mypassword" | ConvertTo-SecureString -asPlainText -Force))
    
    $TestCases = @(
        @{ 
            'Name' = '.png'
            'MimeType' = 'image/png'
        }, 
        @{ 
            'Name' = '.jpg'
            'MimeType' = 'image/jpeg'
        }, 
        @{ 
            'Name' = '.gif'
            'MimeType' = 'image/gif'
        }, 
        @{ 
            'Name' = '.tiff'
            'MimeType' = 'image/tiff'
        }, 
        @{ 
            'Name' = '.pdf'
            'MimeType' = 'application/pdf'
        }, 
        @{ 
            'Name' = '.Zip'
            'MimeType' = 'application/zip'
        }, 
        @{ 
            'Name' = '.mov'
            'MimeType' = 'video/quicktime'
        }, 
        @{ 
            'Name' = '.mp4'
            'MimeType' = 'video/mp4'
        }, 
        @{ 
            'Name' = '.mpg'
            'MimeType' = 'video/mpeg'
        }, 
        @{ 
            'Name' = '.mpeg'
            'MimeType' = 'video/mpeg'
        }, 
        @{ 
            'Name' = '.uknow'
            'MimeType' = 'application/octet-stream'
        }
    )
    
    $TestFiles = $TestCases | ForEach-Object { 
        New-Item -Path 'TestDrive:\' -Name "InFile$($_.Name)" -ItemType file
    }

    $InvokeSplat = @{ 
        'InstanceName' = 'Instance'
        'Credential' = $DummyCreds
        'table_name' = 'TableName'
        'table_sys_id' = '12345678901234567890123456789012'
    }

    it 'Should Set MimeTypes correct, <Name> - <MimeType>' -TestCases $TestCases {
        Param(
            $Name,
            $MimeType
        )
        $Path = "TestDrive:\InFile$Name".Replace('TestDrive:', (Get-PSDrive TestDrive).Root)
        (New-ServiceNowAttachment @InvokeSplat -Path $Path).ContentType | Should -Be $MimeType
    }
    
    $Path = Join-Path -Path (Get-PSDrive TestDrive).Root -ChildPath 'InFile.uknow'
    $Actual = New-ServiceNowAttachment @InvokeSplat -Path $Path

    it 'Url should be correct' {
        $Actual.Uri | Should -Be 'https://instance.service-now.com/api/now/attachment/file?table_name=TableName&table_sys_id=12345678901234567890123456789012&file_name=InFile.uknow'
    }
    
    it 'Method should be post' {
        $Actual.Method |Should -Be 'Post'
    }
    
    it 'Body should be Byte Array' {
        $Actual.Body.GetType().FullName | Should -Be 'System.Byte[]'
    }

    Assert-VerifiableMock
}