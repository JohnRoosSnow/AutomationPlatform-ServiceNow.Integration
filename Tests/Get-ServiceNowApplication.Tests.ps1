$FunctionName = 'Get-ServiceNowApplication'

Describe 'Import function tests' -Tag 'PreBuild' {
    It 'Function should not be loaded' {
        Remove-Item Function:\$FunctionName -Force -ErrorAction SilentlyContinue
        { Get-Command $FunctionName -ErrorAction Stop } | Should -Throw
    }
    It 'Function should load when dot sourcing file' {
        . $PSScriptRoot\..\Public\Get-ServiceNowApplication.ps1
        (Get-Command $FunctionName).Name | Should -Be $FunctionName
    }
}

. $PSScriptRoot\..\Public\Get-ServiceNowApplication.ps1

Describe 'Parameters' {
    $ActualParameters = (Get-Command Get-ServiceNowApplication).Parameters
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
            'ParamName' = 'Name'
            'ParamType' = 'String'
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



$MockObject = @'
{
    "result":  [
        {
            "tcp_port":  "",
            "u_axosoft_id":  "",
            "skip_sync":  "false",
            "operational_status":  "1",
            "running_process_command":  "",
            "pid":  "",
            "running_process_parameters":  "",
            "sys_updated_on":  "1900-00-00 00:00:01",
            "running_process_key_parameters":  "",
            "rp_command_hash":  "",
            "discovery_source":  "",
            "first_discovered":  "",
            "sys_updated_by":  "user@mail.com",
            "due_in":  "",
            "install_directory":  "",
            "sys_created_on":  "1900-00-00 00:00:01",
            "sys_domain":  {
                               "link":  "https://snowstage.service-now.com/api/now/table/sys_user_group/global",
                               "value":  "global"
                           },
            "used_for":  "Production",
            "install_date":  "",
            "is_clustered":  "false",
            "gl_account":  "",
            "invoice_number":  "",
            "sys_created_by":  "user@mail.com",
            "warranty_expiration":  "",
            "asset_tag":  "",
            "fqdn":  "",
            "change_control":  "",
            "owned_by":  "",
            "checked_out":  "",
            "rp_key_parameters_hash":  "",
            "sys_domain_path":  "/",
            "version":  "",
            "u_parent":  {
                             "link":  "https://snowstage.service-now.com/api/now/table/cmdb_ci_appl/aaaaaaaaaaaaaaaa0000000000000001",
                             "value":  "aaaaaaaaaaaaaaaa0000000000000001"
                         },
            "delivery_date":  "",
            "maintenance_schedule":  "",
            "u_display_name":  "application1",
            "install_status":  "1",
            "u_template":  "",
            "supported_by":  "",
            "dns_domain":  "",
            "name":  "application1",
            "u_kb_faq":  "",
            "assigned":  "",
            "purchase_date":  "",
            "subcategory":  "",
            "short_description":  "",
            "assignment_group":  "",
            "managed_by":  "",
            "edition":  "",
            "can_print":  "false",
            "last_discovered":  "",
            "sys_class_name":  "u_application_version",
            "manufacturer":  "",
            "sys_id":  "aaaaaaaaaaaaaaaa0000000000000001",
            "po_number":  "",
            "checked_in":  "",
            "sys_class_path":  "/!!/!$/#`",
            "mac_address":  "",
            "vendor":  "",
            "company":  "",
            "justification":  "",
            "model_number":  "",
            "department":  "",
            "config_file":  "",
            "u_temp_application":  "",
            "assigned_to":  "",
            "start_date":  "",
            "comments":  "",
            "cost":  "",
            "sys_mod_count":  "0",
            "monitor":  "false",
            "serial_number":  "",
            "ip_address":  "",
            "model_id":  "",
            "sys_tags":  "",
            "cost_cc":  "USD",
            "order_date":  "",
            "schedule":  "",
            "support_group":  "",
            "due":  "",
            "correlation_id":  "",
            "unverified":  "false",
            "attributes":  "",
            "location":  "",
            "asset":  "",
            "category":  "",
            "fault_count":  "0",
            "config_directory":  "",
            "lease_id":  ""
        },
        {
            "tcp_port":  "",
            "u_axosoft_id":  "",
            "skip_sync":  "false",
            "operational_status":  "1",
            "running_process_command":  "",
            "pid":  "",
            "running_process_parameters":  "",
            "sys_updated_on":  "1900-00-00 00:00:01",
            "running_process_key_parameters":  "",
            "rp_command_hash":  "",
            "discovery_source":  "",
            "first_discovered":  "",
            "sys_updated_by":  "user@mail.com",
            "due_in":  "",
            "install_directory":  "",
            "sys_created_on":  "1900-00-00 00:00:01",
            "sys_domain":  {
                               "link":  "https://snowstage.service-now.com/api/now/table/sys_user_group/global",
                               "value":  "global"
                           },
            "used_for":  "Production",
            "install_date":  "",
            "is_clustered":  "false",
            "gl_account":  "",
            "invoice_number":  "",
            "sys_created_by":  "user@mail.com",
            "warranty_expiration":  "",
            "asset_tag":  "",
            "fqdn":  "",
            "change_control":  "",
            "owned_by":  "",
            "checked_out":  "",
            "rp_key_parameters_hash":  "",
            "sys_domain_path":  "/",
            "version":  "",
            "u_parent":  "",
            "delivery_date":  "",
            "maintenance_schedule":  "",
            "u_display_name":  "application2",
            "install_status":  "1",
            "u_template":  "",
            "supported_by":  "",
            "dns_domain":  "",
            "name":  "application2",
            "u_kb_faq":  "",
            "assigned":  "",
            "purchase_date":  "",
            "subcategory":  "",
            "short_description":  "",
            "assignment_group":  "",
            "managed_by":  "",
            "edition":  "",
            "can_print":  "false",
            "last_discovered":  "",
            "sys_class_name":  "u_application_version",
            "manufacturer":  "",
            "sys_id":  "aaaaaaaaaaaaaaaa0000000000000002",
            "po_number":  "",
            "checked_in":  "",
            "sys_class_path":  "/!!/!$/#`",
            "mac_address":  "",
            "vendor":  "",
            "company":  "",
            "justification":  "",
            "model_number":  "",
            "department":  "",
            "config_file":  "",
            "u_temp_application":  "",
            "assigned_to":  "",
            "start_date":  "",
            "comments":  "",
            "cost":  "",
            "sys_mod_count":  "0",
            "monitor":  "false",
            "serial_number":  "",
            "ip_address":  "",
            "model_id":  "",
            "sys_tags":  "",
            "cost_cc":  "USD",
            "order_date":  "",
            "schedule":  "",
            "support_group":  "",
            "due":  "",
            "correlation_id":  "",
            "unverified":  "false",
            "attributes":  "",
            "location":  "",
            "asset":  "",
            "category":  "",
            "fault_count":  "0",
            "config_directory":  "",
            "lease_id":  ""
        },
        {
            "tcp_port":  "",
            "u_axosoft_id":  "",
            "skip_sync":  "false",
            "operational_status":  "1",
            "running_process_command":  "",
            "pid":  "",
            "running_process_parameters":  "",
            "sys_updated_on":  "1900-00-00 00:00:01",
            "running_process_key_parameters":  "",
            "rp_command_hash":  "",
            "discovery_source":  "",
            "first_discovered":  "",
            "sys_updated_by":  "user@mail.com",
            "due_in":  "",
            "install_directory":  "",
            "sys_created_on":  "1900-00-00 00:00:01",
            "sys_domain":  {
                               "link":  "https://snowstage.service-now.com/api/now/table/sys_user_group/global",
                               "value":  "global"
                           },
            "used_for":  "Production",
            "install_date":  "",
            "is_clustered":  "false",
            "gl_account":  "",
            "invoice_number":  "",
            "sys_created_by":  "user@mail.com",
            "warranty_expiration":  "",
            "asset_tag":  "",
            "fqdn":  "",
            "change_control":  "",
            "owned_by":  "",
            "checked_out":  "",
            "rp_key_parameters_hash":  "",
            "sys_domain_path":  "/",
            "version":  "",
            "u_parent":  {
                             "link":  "https://snowstage.service-now.com/api/now/table/cmdb_ci_appl/aaaaaaaaaaaaaaaa0000000000000003",
                             "value":  "aaaaaaaaaaaaaaaa0000000000000003"
                         },
            "delivery_date":  "",
            "maintenance_schedule":  "",
            "u_display_name":  "application3",
            "install_status":  "1",
            "u_template":  "",
            "supported_by":  "",
            "dns_domain":  "",
            "name":  "application3",
            "u_kb_faq":  "",
            "assigned":  "",
            "purchase_date":  "",
            "subcategory":  "",
            "short_description":  "",
            "assignment_group":  "",
            "managed_by":  "",
            "edition":  "",
            "can_print":  "false",
            "last_discovered":  "",
            "sys_class_name":  "u_application_version",
            "manufacturer":  "",
            "sys_id":  "aaaaaaaaaaaaaaaa0000000000000003",
            "po_number":  "",
            "checked_in":  "",
            "sys_class_path":  "/!!/!$/#`",
            "mac_address":  "",
            "vendor":  "",
            "company":  "",
            "justification":  "",
            "model_number":  "",
            "department":  "",
            "config_file":  "",
            "u_temp_application":  "",
            "assigned_to":  "",
            "start_date":  "",
            "comments":  "",
            "cost":  "",
            "sys_mod_count":  "0",
            "monitor":  "false",
            "serial_number":  "",
            "ip_address":  "",
            "model_id":  "",
            "sys_tags":  "",
            "cost_cc":  "USD",
            "order_date":  "",
            "schedule":  "",
            "support_group":  "",
            "due":  "",
            "correlation_id":  "",
            "unverified":  "false",
            "attributes":  "",
            "location":  "",
            "asset":  "",
            "category":  "",
            "fault_count":  "0",
            "config_directory":  "",
            "lease_id":  ""
        },
        {
            "tcp_port":  "",
            "u_axosoft_id":  "",
            "skip_sync":  "false",
            "operational_status":  "1",
            "running_process_command":  "",
            "pid":  "",
            "running_process_parameters":  "",
            "sys_updated_on":  "1900-00-00 00:00:01",
            "running_process_key_parameters":  "",
            "rp_command_hash":  "",
            "discovery_source":  "",
            "first_discovered":  "",
            "sys_updated_by":  "user@mail.com",
            "due_in":  "",
            "install_directory":  "",
            "sys_created_on":  "1900-00-00 00:00:01",
            "sys_domain":  {
                               "link":  "https://snowstage.service-now.com/api/now/table/sys_user_group/global",
                               "value":  "global"
                           },
            "used_for":  "Production",
            "install_date":  "",
            "is_clustered":  "false",
            "gl_account":  "",
            "invoice_number":  "",
            "sys_created_by":  "user@mail.com",
            "warranty_expiration":  "",
            "asset_tag":  "",
            "fqdn":  "",
            "change_control":  "",
            "owned_by":  "",
            "checked_out":  "",
            "rp_key_parameters_hash":  "",
            "sys_domain_path":  "/",
            "version":  "",
            "u_parent":  {
                             "link":  "https://snowstage.service-now.com/api/now/table/cmdb_ci_appl/aaaaaaaaaaaaaaaa0000000000000004",
                             "value":  "aaaaaaaaaaaaaaaa0000000000000004"
                         },
            "delivery_date":  "",
            "maintenance_schedule":  "",
            "u_display_name":  "application4",
            "install_status":  "1",
            "u_template":  "",
            "supported_by":  "",
            "dns_domain":  "",
            "name":  "application4",
            "u_kb_faq":  "",
            "assigned":  "",
            "purchase_date":  "",
            "subcategory":  "",
            "short_description":  "",
            "assignment_group":  "",
            "managed_by":  "",
            "edition":  "",
            "can_print":  "false",
            "last_discovered":  "",
            "sys_class_name":  "u_application_component",
            "manufacturer":  "",
            "sys_id":  "aaaaaaaaaaaaaaaa0000000000000004",
            "po_number":  "",
            "checked_in":  "",
            "sys_class_path":  "/!!/!$/#^",
            "mac_address":  "",
            "vendor":  "",
            "company":  "",
            "justification":  "",
            "model_number":  "",
            "department":  "",
            "config_file":  "",
            "u_temp_application":  "",
            "assigned_to":  "",
            "start_date":  "",
            "comments":  "",
            "cost":  "",
            "sys_mod_count":  "0",
            "monitor":  "false",
            "serial_number":  "",
            "ip_address":  "",
            "model_id":  "",
            "sys_tags":  "",
            "cost_cc":  "USD",
            "order_date":  "",
            "schedule":  "",
            "support_group":  "",
            "due":  "",
            "correlation_id":  "",
            "unverified":  "false",
            "attributes":  "",
            "location":  "",
            "asset":  "",
            "category":  "",
            "fault_count":  "0",
            "config_directory":  "",
            "lease_id":  ""
        },
        {
            "tcp_port":  "",
            "u_axosoft_id":  "",
            "skip_sync":  "false",
            "operational_status":  "1",
            "running_process_command":  "",
            "pid":  "",
            "running_process_parameters":  "",
            "sys_updated_on":  "1900-00-00 00:00:01",
            "running_process_key_parameters":  "",
            "rp_command_hash":  "",
            "discovery_source":  "",
            "first_discovered":  "",
            "sys_updated_by":  "user@mail.com",
            "due_in":  "",
            "install_directory":  "",
            "sys_created_on":  "1900-00-00 00:00:01",
            "sys_domain":  {
                               "link":  "https://snowstage.service-now.com/api/now/table/sys_user_group/global",
                               "value":  "global"
                           },
            "used_for":  "Production",
            "install_date":  "",
            "is_clustered":  "false",
            "gl_account":  "",
            "invoice_number":  "",
            "sys_created_by":  "user@mail.com",
            "warranty_expiration":  "",
            "asset_tag":  "",
            "fqdn":  "",
            "change_control":  "",
            "owned_by":  "",
            "checked_out":  "",
            "rp_key_parameters_hash":  "",
            "sys_domain_path":  "/",
            "version":  "",
            "u_parent":  "",
            "delivery_date":  "",
            "maintenance_schedule":  "",
            "u_display_name":  "application5",
            "install_status":  "1",
            "u_template":  "",
            "supported_by":  "",
            "dns_domain":  "",
            "name":  "application5",
            "u_kb_faq":  "",
            "assigned":  "",
            "purchase_date":  "",
            "subcategory":  "",
            "short_description":  "",
            "assignment_group":  "",
            "managed_by":  "",
            "edition":  "",
            "can_print":  "false",
            "last_discovered":  "",
            "sys_class_name":  "u_application_version",
            "manufacturer":  "",
            "sys_id":  "aaaaaaaaaaaaaaaa0000000000000005",
            "po_number":  "",
            "checked_in":  "",
            "sys_class_path":  "/!!/!$/#`",
            "mac_address":  "",
            "vendor":  "",
            "company":  "",
            "justification":  "",
            "model_number":  "",
            "department":  "",
            "config_file":  "",
            "u_temp_application":  "",
            "assigned_to":  "",
            "start_date":  "",
            "comments":  "",
            "cost":  "",
            "sys_mod_count":  "0",
            "monitor":  "false",
            "serial_number":  "",
            "ip_address":  "",
            "model_id":  "",
            "sys_tags":  "",
            "cost_cc":  "USD",
            "order_date":  "",
            "schedule":  "",
            "support_group":  "",
            "due":  "",
            "correlation_id":  "",
            "unverified":  "false",
            "attributes":  "",
            "location":  "",
            "asset":  "",
            "category":  "",
            "fault_count":  "0",
            "config_directory":  "",
            "lease_id":  ""
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
    Context 'Invoke settings' { 
        Mock Invoke-RestMethod -MockWith {
            New-Object -TypeName psobject -Property @{
                result = $KBInvokeSplat
            }
        } -Verifiable
        
        $Actual = Get-ServiceNowApplication @InvokeSplat 
        
        it 'Invoke should have correct parameters, URI' {
            $Actual.Uri | Should -Be 'https://Instance.service-now.com/api/now/table/cmdb_ci_appl'
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
            $Uri -eq 'https://Instance.service-now.com/api/now/table/cmdb_ci_appl'
        } -MockWith {
            return $MockObject
        } -Verifiable
        
        it 'Searching with no name parameter should return five objects' {
            @(Get-ServiceNowApplication @InvokeSplat ).name.count | Should -Be 5
        }

        it 'Searching with non existing name returns zero objects' {
            Get-ServiceNowApplication @InvokeSplat -Name 'none' | Should -BeNullOrEmpty
        }

        it 'Searching with exact name returns one object' {
            @(Get-ServiceNowApplication @InvokeSplat -Name 'application1').Count | Should -Be 1
        }

        it 'Searching with fuzzy name returns five objects' {
            @(Get-ServiceNowApplication @InvokeSplat -Name 'application').Count | Should -Be 5
        }

        Assert-VerifiableMock
    }
}

