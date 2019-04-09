---
external help file: AutomationPlatform-ServiceNow.Integration-help.xml
Module Name: AutomationPlatform-ServiceNow.Integration
online version:
schema: 2.0.0
---

# New-ServiceNowKB

## SYNOPSIS
Crete a new KB Article in Service Now.

## SYNTAX

```
New-ServiceNowKB [-InstanceName] <String> [-Credential] <PSCredential> [-kb_knowledge_base] <String>
 [-u_category] <String> [-u_application] <String> [-short_description] <String> [[-text] <String>]
 [[-u_article_state] <String>] [<CommonParameters>]
```

## DESCRIPTION
This CmdLet lets you create a new KB article in Service now.

## EXAMPLES

### Example 1
```powershell
PS C:\> $Splat = @{
    'InstanceName'      = 'instance'
    'Credential'        = $PSCredential
    'kb_knowledge_base' = '12345678901234567890123456789012'
    'u_category'        = 'KB_Article'
    'u_application'     = '12345678901234567890123456789012'
    'short_description' = 'short desc'
    'text'              = '<b>this is text</b>'
    'u_article_state'   = 'publish'
}
PS C:\> New-ServiceNowKB @Splat
```

This command will create a new KB article in 'https://instance.service-now.com',
It will imediately be published, with text and description as set,
commected to the knowledgebase with sys_id 12345678901234567890123456789012
and the application with sys_id 12345678901234567890123456789012

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
The knowledge base sys_id to which the KB article will be connected.
This id can be retrieved using the Get-ServiceNowKnowledgeBase CmdLet.

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
Short description of what the KB article is about.

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
Contents of the KB article. This field can be HTML formated, or clear text.

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
The application sys_id to which the KB article will be connected.
This can be retrieved using the Get-ServiceNowApplication CmdLet.

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
The state the article will be in when created.

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
The category connected to the KB article.

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
