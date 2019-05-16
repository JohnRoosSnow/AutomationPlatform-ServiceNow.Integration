---
external help file: Snow.SnowAutomationPlatform.ServiceNow.Integration-help.xml
Module Name: Snow.SnowAutomationPlatform.ServiceNow.Integration
online version:
schema: 2.0.0
---

# Set-ServiceNowKB

## SYNOPSIS
Update a service now KB article.

# Set-ServiceNowKB

## SYNOPSIS
Update a service now KB article.

## SYNTAX

### Object (Default)
```
Set-ServiceNowKB -InstanceName <String> -Credential <PSCredential> -ServiceNowObject <PSObject>
 [<CommonParameters>]
```

### Field
```
Set-ServiceNowKB -InstanceName <String> -Credential <PSCredential> -Field <String> -Text <String>
 -sys_id <String> [<CommonParameters>]
```

## DESCRIPTION
This CmdLet will update a service now KB article using either an object as returned from Get-ServiceNowKB 
Or defining a field and value to update.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-ServiceNowKB -InstanceName Instance -Credential $PSCredential -Field text -Text 'Some new text' -sys_id '12345678901234567890123456789012'
```

This command will change the text field to 'some new text' in the kb artice with sys_id 12345678901234567890123456789012

### Example 2
```powershell
PS C:\> $a = Get-ServiceNowKB -QueryParameter 'Number' -QueryOperator '=' -QueryValue 'PROB123' -InstanceName 'MyInstance' -Credential $Creds
PS C:\> $a.text = 'Some new text'
PS C:\> Set-ServiceNowKB -InstanceName Instance -Credential $PSCredential -ServiceNowObject $a
```

This command will change the text field to 'some new text' in the kb artice returned by the Get-ServiceNowKB query.

## PARAMETERS

### -Credential
Credential allowed to read the Service Now API

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Field
Field Name to update with new text

```yaml
Type: String
Parameter Sets: Field
Aliases:

Required: True
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceNowObject
ServiceNow object as returned by the Get-ServiceNowKB CmdLet

```yaml
Type: PSObject
Parameter Sets: Object
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
This text will replace the current value of the field parameter.

```yaml
Type: String
Parameter Sets: Field
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sys_id
System ID of the article to update.

```yaml
Type: String
Parameter Sets: Field
Aliases:

Required: True
Position: Named
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
