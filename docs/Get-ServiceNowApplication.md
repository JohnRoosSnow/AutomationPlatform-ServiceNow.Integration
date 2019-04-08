---
external help file: AutomationPlatform-ServiceNow.Integration-help.xml
Module Name: AutomationPlatform-ServiceNow.Integration
online version:
schema: 2.0.0
---

# Get-ServiceNowApplication

## SYNOPSIS
Searches the Service Now databse for Applications

## SYNTAX

```
Get-ServiceNowApplication [-InstanceName] <String> [-Credential] <PSCredential> [[-Name] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This CmdLet searches the Service Now databse for applications needed when creating a new KB article.
You may include a name to search for to filter out mathing applications.
Name is not case sensitive.
If name is omitted this CmdLet will return all applications found.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ServiceNowApplication -Instance 'MyServiceNowInstance' -Credential $Creds -Name 'MyApplication'
```

This will return any applications matching 'MyApplication'.
'MyApplication' Will match
'myapplication' Will match
'ThisIsMyApplication' Will match
'ThisIsMyApplicationAsWell' Will match

### Example 2
```powershell
PS C:\> Get-ServiceNowApplication -Instance 'MyServiceNowInstance' -Credential $Creds
```

This will return all applications in the applications database.

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

### -Name
Name of the application to filter the search for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
