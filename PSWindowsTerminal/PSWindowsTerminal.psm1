Get-ChildItem -Path $PSScriptRoot\Public,$PSScriptRoot\Private | ForEach-Object -Process {
    . $_.FullName
}

$Script:ExceptionList = Import-PowerShellDataFile -Path $PSScriptRoot\Configs\Exceptions.psd1

Export-ModuleMember -Function * -Alias *