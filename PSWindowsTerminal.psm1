Get-ChildItem -Path $PSScriptRoot\Public,$PSScriptRoot\Private | ForEach-Object -Process {
    . $_.FullName
}

$ExceptionList = Import-PowerShellDataFile -Path $PSScriptRoot\Configs\Exceptions.psd1

Export-ModuleMember -Function * -Alias *