$FunctionName = 'Get-ServiceNowKnowledgeBase'

Describe 'Import function tests' -Tag 'PreBuild' {
    It 'Function should not be loaded' {
        Remove-Item Function:\$FunctionName -Force -ErrorAction SilentlyContinue
        { Get-Command $FunctionName -ErrorAction Stop } | Should -Throw
    }
    It 'Function should load when dot sourcing file' {
        . ..\Public\Get-ServiceNowKnowledgeBase.ps1
        (Get-Command $FunctionName).Name | Should -Be $FunctionName
    }
}

. ..\Public\Get-ServiceNowKnowledgeBase.ps1

Describe 'Parameters' {
    $ActualParameters = (Get-Command Get-ServiceNowKnowledgeBase).Parameters
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


$MockObject = @'
{
    "result":  [
                   {
                       "mandatory_fields":  "",
                       "template":  "",
                       "enable_socialqa":  "false",
                       "icon":  "",
                       "description":  "This is a knowledgebase",
                       "question_annotation":  "",
                       "sys_updated_on":  "1900-01-01 00:00:01",
                       "title":  "Knowledgebase1",
                       "disable_suggesting":  "true",
                       "u_internal_only":  "false",
                       "sys_id":  "aaaaaaaaaaaaaaaa0000000000000001",
                       "disable_category_editing":  "true",
                       "sys_updated_by":  "user.name@email.com",
                       "disable_commenting":  "false",
                       "sys_created_on":  "1900-01-01 00:00:01",
                       "sys_domain":  "@{link=https://domain.service-now.com/api/now/table/sys_user_group/global; value=global}",
                       "kb_version":  "3",
                       "sys_created_by":  "user.name@email.com",
                       "table":  "kb_knowledge",
                       "order":  "",
                       "owner":  "@{link=https://domain.service-now.com/api/now/table/sys_user/aaaaaaaaaa0000000000000aaaa000aa; value=aaaaaaaaaa0000000000000aaaa000aa}",
                       "approval_description":  "",
                       "sys_mod_count":  "7",
                       "active":  "true",
                       "sys_tags":  "",
                       "card_color":  "",
                       "kb_managers":  "aaaaaaaaaa0000000000000aaaa000aa"
                   },
                   {
                       "mandatory_fields":  "",
                       "template":  "",
                       "enable_socialqa":  "false",
                       "icon":  "",
                       "description":  "This is a knowledgebase",
                       "question_annotation":  "",
                       "sys_updated_on":  "1900-01-01 00:00:01",
                       "title":  "Knowledgebase2",
                       "disable_suggesting":  "true",
                       "u_internal_only":  "true",
                       "sys_id":  "aaaaaaaaaaaaaaaa0000000000000002",
                       "disable_category_editing":  "true",
                       "sys_updated_by":  "user.name@email.com",
                       "disable_commenting":  "true",
                       "sys_created_on":  "1900-01-01 00:00:01",
                       "sys_domain":  "@{link=https://domain.service-now.com/api/now/table/sys_user_group/global; value=global}",
                       "kb_version":  "3",
                       "sys_created_by":  "user.name@email.com",
                       "table":  "kb_knowledge",
                       "order":  "",
                       "owner":  "@{link=https://domain.service-now.com/api/now/table/sys_user/aaaaaaaaaa0000000000000aaaa000aa; value=aaaaaaaaaa0000000000000aaaa000aa}",
                       "approval_description":  "",
                       "sys_mod_count":  "7",
                       "active":  "true",
                       "sys_tags":  "",
                       "card_color":  "",
                       "kb_managers":  "aaaaaaaaaa0000000000000aaaa000aa"
                   },
                   {
                       "mandatory_fields":  "",
                       "template":  "",
                       "enable_socialqa":  "false",
                       "icon":  "",
                       "description":  "This is a knowledgebase",
                       "question_annotation":  "",
                       "sys_updated_on":  "1900-01-01 00:00:01",
                       "title":  "3Knowledgebase",
                       "disable_suggesting":  "true",
                       "u_internal_only":  "false",
                       "sys_id":  "aaaaaaaaaaaaaaaa0000000000000003",
                       "disable_category_editing":  "true",
                       "sys_updated_by":  "user.name@email.com",
                       "disable_commenting":  "true",
                       "sys_created_on":  "1900-01-01 00:00:01",
                       "sys_domain":  "@{link=https://domain.service-now.com/api/now/table/sys_user_group/global; value=global}",
                       "kb_version":  "3",
                       "sys_created_by":  "user.name@email.com",
                       "table":  "kb_knowledge",
                       "order":  "",
                       "owner":  "@{link=https://domain.service-now.com/api/now/table/sys_user/aaaaaaaaaa0000000000000aaaa000aa; value=aaaaaaaaaa0000000000000aaaa000aa}",
                       "approval_description":  "",
                       "sys_mod_count":  "6",
                       "active":  "true",
                       "sys_tags":  "",
                       "card_color":  "",
                       "kb_managers":  "aaaaaaaaaa0000000000000aaaa000aa"
                   },
                   {
                       "mandatory_fields":  "",
                       "template":  "",
                       "enable_socialqa":  "false",
                       "icon":  "",
                       "description":  "This is a knowledgebase",
                       "question_annotation":  "",
                       "sys_updated_on":  "1900-01-01 00:00:01",
                       "title":  "4Knowledgebase",
                       "disable_suggesting":  "true",
                       "u_internal_only":  "false",
                       "sys_id":  "aaaaaaaaaaaaaaaa0000000000000004",
                       "disable_category_editing":  "true",
                       "sys_updated_by":  "user.name@email.com",
                       "disable_commenting":  "true",
                       "sys_created_on":  "1900-01-01 00:00:01",
                       "sys_domain":  "@{link=https://domain.service-now.com/api/now/table/sys_user_group/global; value=global}",
                       "kb_version":  "3",
                       "sys_created_by":  "user.name@email.com",
                       "table":  "kb_knowledge",
                       "order":  "",
                       "owner":  "@{link=https://domain.service-now.com/api/now/table/sys_user/aaaaaaaaaa0000000000000aaaa000aa; value=aaaaaaaaaa0000000000000aaaa000aa}",
                       "approval_description":  "",
                       "sys_mod_count":  "2",
                       "active":  "true",
                       "sys_tags":  "",
                       "card_color":  "",
                       "kb_managers":  ""
                   }
               ]
}
'@ | ConvertFrom-Json

$DummyCreds = New-Object System.Management.Automation.PSCredential('DummyUser', ("mypassword" | ConvertTo-SecureString -asPlainText -Force))
$InvokeSplat = @{
    'InstanceName' = 'Instance'
    'Credential'   = $DummyCreds
}

Describe 'Calling API' {
    Context 'Searching for kb' { 
        Mock Invoke-RestMethod -MockWith {
            New-Object -TypeName psobject -Property @{
                result = $KBInvokeSplat
            }
        } -Verifiable
        
        $Actual = Get-ServiceNowKnowledgeBase @InvokeSplat 
        
        it 'Invoke should have correct parameters, URI' {
            $Actual.Uri | Should -Be 'https://Instance.service-now.com/api/now/table/kb_knowledge_base'
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
    
    Context 'Searching for kb' { 
        Mock Invoke-RestMethod -ParameterFilter {
            $Uri -eq 'https://Instance.service-now.com/api/now/table/kb_knowledge_base'
        } -MockWith {
            return $MockObject
        } -Verifiable
        
        $Actual = Get-ServiceNowKnowledgeBase @InvokeSplat 
        
        it 'Searching should return four KB objects' {
            $Actual.title.count | Should -Be 4
        }

        Assert-VerifiableMock
    }
}

