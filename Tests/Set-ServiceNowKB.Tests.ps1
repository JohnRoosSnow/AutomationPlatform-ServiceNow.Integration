$FunctionName = 'Set-ServiceNowKB'

Describe 'Import function tests' -Tag 'PreBuild' {
    It 'Function should not be loaded' {
        Remove-Item Function:\$FunctionName -Force -ErrorAction SilentlyContinue
        { Get-Command $FunctionName -ErrorAction Stop } | Should -Throw
    }
    It 'Function should load when dot sourcing file' {
        . ..\Public\$($FunctionName).ps1
        (Get-Command $FunctionName).Name | Should -Be $FunctionName
    }
}

. ..\Public\$($FunctionName).ps1

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
            'ParamName' = 'ServiceNowObject'
            'ParamType' = 'PSObject'
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

. ..\Public\Set-ServiceNowKB.ps1

$MockObject = @'
{
    "result": [
      {
        "u_group": {
          "link": "https://instance.service-now.com/api/now/table/sys_user_group/7081f0100f96f500961729a703050e98",
          "value": "00000000000000000000000000000001"
        },
        "wiki": null,
        "rating": "",
        "source": "",
        "sys_updated_on": "2019-01-01 01:01:01",
        "u_title_comment": "",
        "u_watch_list": "",
        "u_score": "0",
        "number": "KB1234567",
        "sys_updated_by": "user@mail.com",
        "u_group_list": "",
        "latest_aqi": "",
        "sys_created_on": "2019-01-01 01:01:01",
        "sys_domain": {
          "link": "https://instance.service-now.com/api/now/table/sys_user_group/global",
          "value": "global"
        },
        "workflow_state": "draft",
        "text": "Text",
        "u_title_checkbox": "false",
        "sys_created_by": "user@mail.com",
        "u_application_area": "",
        "image": "",
        "u_work_notes": "",
        "cmdb_ci": "",
        "author": {
          "link": "https://instance.service-now.com/api/now/table/sys_user/00000000000000000000000000000002",
          "value": "00000000000000000000000000000002"
        },
        "u_metadata_comment": "",
        "can_read_user_criteria": "",
        "active": "true",
        "u_language": "English",
        "cannot_read_user_criteria": "",
        "published": "",
        "u_coach": "",
        "u_unique_comment": "",
        "version": {
          "link": "https://instance.service-now.com/api/now/table/kb_version/00000000000000000000000000000003",
          "value": "00000000000000000000000000000003"
        },
        "meta_description": "Text",
        "u_application_component": "",
        "kb_knowledge_base": {
          "link": "https://instance.service-now.com/api/now/table/kb_knowledge_base/00000000000000000000000000000004",
          "value": "00000000000000000000000000000004"
        },
        "meta": "",
        "u_references_comment": "",
        "u_article_state": "1",
        "topic": "",
        "display_number": "KB1234567 v0.01",
        "base_version": "",
        "short_description": "test",
        "u_metadata_checkbox": "false",
        "u_version": "",
        "roles": "",
        "direct": "false",
        "description": "",
        "u_link_accurate": "false",
        "disable_suggesting": "true",
        "sys_class_name": "kb_knowledge",
        "u_complete_comment": "",
        "u_test_topic": "",
        "article_id": "00000000000000000000000000000005",
        "sys_id": "00000000000000000000000000000005",
        "use_count": "0",
        "u_internal_text": "",
        "flagged": "false",
        "disable_commenting": "false",
        "valid_to": "2020-01-01",
        "u_unique_checkbox": "false",
        "retired": "",
        "u_references_checkbox": "false",
        "display_attachments": "false",
        "latest": "true",
        "sys_view_count": "0",
        "u_complete_checkbox": "false",
        "revised_by": "",
        "article_type": "text",
        "u_count_task": "0",
        "u_date_coached": "",
        "sys_mod_count": "5",
        "u_content_clear_comment": "",
        "u_release": "",
        "u_script": "",
        "sys_tags": "",
        "u_category": "product_releases",
        "u_content_clear_checkbox": "false",
        "u_application": {
          "link": "https://instance.service-now.com/api/now/table/cmdb_ci_appl/00000000000000000000000000000006",
          "value": "00000000000000000000000000000006"
        },
        "ownership_group": "",
        "category": "",
        "u_knowledge_worker": "",
        "kb_category": ""
      }
    ]
  }
'@ | ConvertFrom-Json

Describe 'updating kb article' {
    Mock -CommandName Invoke-RestMethod -MockWith {
        return $SetKBSplat
    }

    $DummyCreds = New-Object System.Management.Automation.PSCredential('DummyUser', ("mypassword" | ConvertTo-SecureString -asPlainText -Force))

    $KBSplat = @{
        'InstanceName' = 'instance'
        'Credential' = $DummyCreds
    }
    
    Context 'Using object returned from Get-ServiceNowKB as KBObject' {
        it ' Trying to update kb with no sys_id should fail' {
            $KBObj = New-Object -TypeName psobject -Property @{
                'a_property' = 'a_value'
            }
            { Set-ServiceNowKB @KBSplat -ServiceNowObject $KBObj } | Should -Throw
        }

        it ' Trying to update kb with bad sys_id should fail' {
            $KBObj = New-Object -TypeName psobject -Property @{
                'sys_id' = 'badSysId'
            }
            { Set-ServiceNowKB @KBSplat -ServiceNowObject $KBObj } | Should -Throw
        }
    
        $Actual = Set-ServiceNowKB @KBSplat -ServiceNowObject $MockObject.result

        it 'Endpoint should be constructed ok' {
            $actual.uri | should -Be 'https://instance.service-now.com/api/now/table/kb_knowledge/00000000000000000000000000000005'
        }

        it 'Body should be a byte array' {
            $actual.Body | Should -BeOfType [Byte]
        }
    }

    Context 'Updating a single value' {
        $Expected = '123,34,116,101,120,116,34,58,34,116,101,120,116,34,125'
        $Actual = Set-ServiceNowKB @KBSplat -Field 'text' -Text 'text'

        it 'Body should be a byte array' {
            $actual.Body | Should -BeOfType [Byte]
        }
        
        it 'Body bytearray should be correct' {
            ($Actual.Body -join ',') | Should -Be $Expected
        }
    }
}