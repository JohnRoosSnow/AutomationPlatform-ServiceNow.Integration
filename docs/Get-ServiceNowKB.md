---
external help file: AutomationPlatform-ServiceNow.Integration-help.xml
Module Name: AutomationPlatform-ServiceNow.Integration
online version:
schema: 2.0.0
---

# Get-ServiceNowKB

## SYNOPSIS
Search the Service Now KB for a specific kb article

## SYNTAX

```
Get-ServiceNowKB [-InstanceName] <String> [-Credential] <PSCredential> [-QueryParameter] <String>
 [-QueryValue] <String> [-QueryOperator] <String> [[-Limit] <UInt32>] [<CommonParameters>]
```

## DESCRIPTION
This CmdLet searches the Service Now KB for a specific article.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ServiceNowKB -QueryParameter 'Number' -QueryOperator 'LIKE' -QueryValue 'PROB123' -Limit 10 -InstanceName 'MyInstance' -Credential $Creds
```

This will search the Service Now KB for any article where the Number matches 'PROB123'.
It will return a maximum of 10 results.
'PROB123' Will match
'prob123' Will match
'MYPROB123' Will match
'PROB123456' Will match
'MYPROB123456' Will match

### Example 2
```powershell
PS C:\> Get-ServiceNowKB -QueryParameter 'Number' -QueryOperator '=' -QueryValue 'PROB123' -InstanceName 'MyInstance' -Credential $Creds
```

This will return a service now KB with the exact number value 'PROB123'.
It will only return one result.

### Example 3
```powershell
PS C:\> Get-ServiceNowKB -QueryParameter 'Text' -QueryOperator 'LIKE' -QueryValue 'problem' -Limit 10000 -InstanceName 'MyInstance' -Credential $Creds
```

This will return any KB article that contains the word Text.
As the limit is set very high this will most likely make the query really slow, and might also crash your PowerShell Session.
Please dont do this.

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
Accepted values: number, text, display_number, short_description, sys_id

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
