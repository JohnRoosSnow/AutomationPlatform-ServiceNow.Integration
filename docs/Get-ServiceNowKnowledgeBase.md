---
external help file: AutomationPlatform-ServiceNow.Integration-help.xml
Module Name: AutomationPlatform-ServiceNow.Integration
online version:
schema: 2.0.0
---

# Get-ServiceNowKnowledgeBase

## SYNOPSIS
Get all Service Now knowledge bases.

## SYNTAX

```
Get-ServiceNowKnowledgeBase [-InstanceName] <String> [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
This CmdLet returns all Service Now Knowledge bases available,
as needed when creating a new KB article.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ServiceNowKnowledgeBase -InstanceName 'MyServiceNowInstance' -Credential $Credential
```

This command will return all available knowledge bases

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
