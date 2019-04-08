---
external help file: AutomationPlatform-ServiceNow.Integration-help.xml
Module Name: AutomationPlatform-ServiceNow.Integration
online version:
schema: 2.0.0
---

# New-ServiceNowKB

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
New-ServiceNowKB [-InstanceName] <String> [-Credential] <PSCredential> [-kb_knowledge_base] <String>
 [-u_category] <String> [-u_application] <String> [-short_description] <String> [[-text] <String>]
 [[-u_article_state] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Credential
Credential allowed to read the Service Now API

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceName
The name of your Service Now instance. This is the first part of the ServiceNow URI.
For example: 
Your service now login page is https://MyServiceNowInstance.service-now.com
Your InstanceName is MyServiceNowInstance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -kb_knowledge_base
{{ Fill kb_knowledge_base Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: knowledge_base

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -short_description
{{ Fill short_description Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -text
{{ Fill text Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -u_application
{{ Fill u_application Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: application

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -u_article_state
{{ Fill u_article_state Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: state
Accepted values: wip, complete, validate, publish

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -u_category
{{ Fill u_category Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: category

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
