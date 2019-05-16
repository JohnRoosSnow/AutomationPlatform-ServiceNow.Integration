---
external help file: Snow.SnowAutomationPlatform.ServiceNow.Integration-help.xml
Module Name: Snow.SnowAutomationPlatform.ServiceNow.Integration
online version:
schema: 2.0.0
---

# Get-ServiceNowAttachment

## SYNOPSIS
This command searches the Service Now database for an attachment.

## SYNTAX

```
Get-ServiceNowAttachment [-InstanceName] <String> [-Credential] <PSCredential> [-QueryParameter] <String>
 [-QueryValue] <String> [-QueryOperator] <String> [[-Limit] <UInt32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ServiceNowAttachment -Instance 'MyServiceNowInstance' -Credential $Creds -QueryParameter 'file_name' -QueryValue 'image.png' -QueryOperator '='
```

This will return any attachments with a file name of 'image.png'


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

### -Limit
Limit query to return this amount of hits.
Default will only return one hit, may be set to any positive value (but will slow down query)

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryOperator
Perform an exact or wildcard search.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: =, LIKE

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryParameter
The parameter to search.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: file_name, sys_tags, sys_id

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryValue
The value to search for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
