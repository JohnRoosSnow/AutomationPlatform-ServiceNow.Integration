$FunctionName = 'New-ServiceNowKB'
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
            'Mandatory' = 'True','True'
        }
        @{
            'ParamName' = 'Credential'
            'ParamType' = 'PSCredential'
            'Mandatory' = 'True','True'
        }
        @{
            'ParamName' = 'kb_knowledge_base'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'u_category'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'u_application'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'short_description'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'text'
            'ParamType' = 'String'
            'Mandatory' = 'false'
        }
        @{
            'ParamName' = 'u_article_state'
            'ParamType' = 'String'
            'Mandatory' = 'false'
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

Describe 'create new kb article' {
    mock -CommandName Invoke-RestMethod -MockWith {
        return $NewKBSplat
    }

    $DummyCreds = New-Object System.Management.Automation.PSCredential('DummyUser', ("mypassword" | ConvertTo-SecureString -asPlainText -Force))

    $InvokeSplat = @{
        'InstanceName' = 'instance'
        'Credential' = $DummyCreds
        'kb_knowledge_base' = '12345678901234567890123456789012'
        'u_category' = 'category'
        'u_application' = '12345678901234567890123456789012'
        'short_description' = 'short_desc'
        'text' = 'text'
        'u_article_state' = 'publish'
    }

    $actual = New-ServiceNowKB @InvokeSplat

    it 'uri should be correct' {
        $actual.uri | Should -Be 'https://instance.service-now.com/api/now/table/kb_knowledge' 
    }
    it 'bodytext should be a bytearray' {
        $actual.body | should -BeOfType [Byte]
    }
}