$FunctionName = 'Get-ServiceNowAttachment'
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
            'ParamName' = 'QueryParameter'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'QueryValue'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'QueryOperator'
            'ParamType' = 'String'
            'Mandatory' = 'True'
        }
        @{
            'ParamName' = 'Limit'
            'ParamType' = 'UInt32'
            'Mandatory' = 'False'
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

$DummyCreds = New-Object System.Management.Automation.PSCredential('DummyUser', ("mypassword" | ConvertTo-SecureString -asPlainText -Force))
$InvokeSplat = @{
    'InstanceName' = 'Instance'
    'Credential'   = $DummyCreds
    'QueryParameter' = 'file_name'
    'QueryValue' = 'file.ext'
    'QueryOperator' = '='
}

Describe 'Calling API' {
    Context 'Searching for attachment' { 
        Mock Invoke-RestMethod -MockWith {
            New-Object -TypeName psobject -Property @{
                result = $KBInvokeSplat
            }
        } -Verifiable
        
        $Actual = Get-ServiceNowAttachment @InvokeSplat 
        
        it 'Invoke should have correct parameters, URI' {
            $Actual.Uri | Should -Be 'https://Instance.service-now.com/api/now/attachment?sysparm_limit=1&sysparm_query=file_name=file.ext'
        }
        it 'Invoke should have correct parameters, Method' {
            $Actual.Method | Should -Be 'Get'
        }
        it 'Invoke should have correct parameters, Credential' {
            $Actual.Credential | Should -Be $DummyCreds
        }
        it 'Invoke should have correct parameters, Headers accept json' {
            $Actual.Headers['accept'] | Should -Be 'application/json'
        }
        
        Assert-VerifiableMock
    }
}

