---
external help file: Snow.SnowAutomationPlatform.ServiceNow.Integration-help.xml
Module Name: Snow.SnowAutomationPlatform.ServiceNow.Integration
online version:
schema: 2.0.0
---

# New-ServiceNowAttachment

## SYNOPSIS
This command creates and attaches a file to a Service Now article.

## SYNTAX

```
New-ServiceNowAttachment [-InstanceName] <String> [-Credential] <PSCredential> [-Path] <String>
 [-table_name] <String> [-table_sys_id] <String> [<CommonParameters>]
```

## DESCRIPTION
This command creates and attaches a file to a Service Now article. 
It will automatically name the attachment, and return the object to be used in other updates.
You have to pre create a kb article in order to upload an attachment.

## EXAMPLES

### Example 1
```powershell
PS C:\> $ImageFullName = (Get-Item '.\images\demoImage.png').FullName
PS C:\> New-ServiceNowAttachment -Path $ImageFullName -table_name 'kb_knowledge' -table_sys_id $KBArticleSys_id -InstanceName 'MyServiceNow' -Credential (Get-Credential)
```

This command will create an attachent and connect to the kb article with sys_id $KBArticleSys_id.

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

### -Path
Full path to the file object to attach.
Relative paths will not work.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Attachment

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -table_name
The name of the table where the object to attach file to is created.

```yaml
Type: String
Parameter Sets: (All)
Aliases: TableName

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -table_sys_id
sys_id of the article to attach file to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: TableSysId

Required: True
Position: 4
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
