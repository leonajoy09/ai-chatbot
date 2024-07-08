$ErrorActionPreference = "Stop"

class Property {
    [string] $Name
    [string] $Type
    [array] $Enum
    [string] $Description
    [array] $Children
    [bool] $Required
    [bool] $Deprecated
    [object] $Default
}

function Resolve-Property($Property, $Defs) {
    $ref = $Property["`$ref"]
    if ($null -ne $ref) {
        return $Defs[$ref.replace("#/`$defs/", "")]
    }
    return $Property
}

function Get-Properties($Schema, $Defs) {
    $properties = @()
    foreach ($key in ($Schema.properties.Keys | Sort-Object)) {
        $property = [Property]::new()
        $resolvedProperty = Resolve-Property $Schema.properties[$key] $Defs
        $property.Name = $key
        $property.Required = $key -in $Schema.required
        $property.Deprecated = $resolvedProperty.deprecated
        $property.Type = $resolvedProperty.type
        $property.Enum = $resolvedProperty.enum | Sort-Object
        $property.Description = $Schema.properties[$key].description
        $property.Default = $Schema.properties[$key].default
        $property.Children = @()

        if ($property.Type -eq "array") {
            $resolvedItems = Resolve-Property $resolvedProperty.items $Defs
            $property.Type = "$($resolvedItems.type)[]"

            if ($resolvedItems.type -eq "object") {
                $children = Get-Properties $resolvedItems $Defs
                foreach ($child in $children) {
                    $property.Children += $child
                }
            }
        }
        elseif (@("object").contains($property.Type)) {
            $children = Get-Properties $resolvedProperty $Defs
            foreach ($child in $children) {
                $property.Children += $child
            }
        }

        if($resolvedProperty.additionalProperties) {
            $resolvedAdditionalProperties = Resolve-Property $resolvedProperty.additionalProperties $Defs
            $property.Type += "{}"
            
            $children = Get-Properties $resolvedAdditionalProperties $Defs
            foreach ($child in $children) {
                $property.Children += $child
            }
        }

        $properties += $property
    }

    return $properties
}

function ConvertTo-Markdown($Properties, $Levels = @()) {

    $output = @(
        "|Name|Type|Description|"
        "|----|----|-----------|"
    )

    foreach ($property in $Properties) {
        $allowedValues = ""
        if ($property.Enum) {
            $allowedValues = $property.Enum -join ", "
            $allowedValues = "<br><br>Allowed values: ``$allowedValues``"
        }

        $defaultValue = ""
        if ($null -ne $property.Default) {
            $defaultValue = $property.Type -eq "boolean" ? $property.Default.ToString().ToLowerInvariant() : $property.Default
            $defaultValue = "<br><br>Default value: ``$defaultValue``"
        }

        $name = "``$($property.Name)``"
        if ($property.Children.Length -gt 0) {
            $myLevels = $Levels + @($property.Name)
            $anchorName = ($myLevels -join "").Replace("[]", "")
            $name = "[``$($property.Name)``](#$anchorName)"
        }

        $description = $property.Description.Replace("`r", "").Replace("`n", "<br>")
        $type = $property.Type ? "``$($property.Type)``" : ""
        $required = $property.Required ? "(Required)" : ""
        $deprecated = $property.Deprecated ? "(Deprecated)" : ""
        $output += "|$name|$type|$required $deprecated $($description) $defaultValue $allowedValues|"
    }

    $output += "`r`n"

    foreach ($property in $Properties) {
        if ($property.Children.Length -gt 0) {
            $myLevels = $Levels + @($property.Name)
            $title = $myLevels -join "."
            $output += "## ``$title``"
            $output += ConvertTo-Markdown $property.Children $myLevels
        }
    }

    return ($output -join "`r`n")
}

function Set-JsonSchemaDocs($JsonSchemaUrl, $MarkdownFilePath) {
    $schema = Invoke-WebRequest $JsonSchemaUrl | ConvertFrom-Json -AsHashtable -Depth 100
    $properties = Get-Properties $schema $schema["`$defs"]

    $markdown = ConvertTo-Markdown $properties
    $markdown | Out-File -FilePath $MarkdownFilePath
}

Set-JsonSchemaDocs `
    -JsonSchemaUrl "https://platweuprdmgmtlzvst.z6.web.core.windows.net/7/config.schema.json" `
    -MarkdownFilePath "schemas/config-7.schema.md"

Set-JsonSchemaDocs `
    -JsonSchemaUrl "https://platweuprdmgmtlzvst.z6.web.core.windows.net/7/network.schema.json" `
    -MarkdownFilePath "schemas/network-7.schema.md"