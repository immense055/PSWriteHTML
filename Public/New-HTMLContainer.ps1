﻿function New-HTMLContainer {
    [alias('Container')]
    [CmdletBinding()]
    param(
        [alias('Content')][Parameter(Mandatory = $false, Position = 0)][ScriptBlock] $HTML,
        [string] $Width,
        [string] $Margin
    )

    if ($Width -or $Margin) {
        [string] $ClassName = "flexElement$(Get-RandomStringName -Size 8 -LettersOnly)"
        $Attributes = @{
            'flex-basis' = if ($Width) { $Width } else { '100%' }
            'margin'     = if ($Margin) { $Margin }
        }
        $Css = ConvertTo-LimitedCSS -ClassName $ClassName -Attributes $Attributes

        $Script:HTMLSchema.CustomHeaderCSS.Add($Css)
        [string] $Class = "$ClassName overflowHidden"
    } else {
        [string] $Class = 'flexElement overflowHidden'
    }
    New-HTMLTag -Tag 'div' -Attributes @{ class = $Class } {
        if ($HTML) {
            Invoke-Command -ScriptBlock $HTML
        }
    }
}