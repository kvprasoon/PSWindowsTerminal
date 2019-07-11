Function CheckPath {
    Param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (-not (Test-Path -Path $Path)) {
        Throw ($Script:ExceptionList.PathNotFound -f $Path)
    }
}

Function Get-WindowsTerminalLocation {
    Param(
        [string]$WTAppName = 'Microsoft.WindowsTerminal'
    )
    $Terminal = Get-AppxPackage -Name $WTAppName
    if ($Null -ne $Terminal) {
        return $Terminal.InstallLocation
    }
    Throw ($Script:ExceptionList.WTNotFound -f $WTAppName)
}

Function Get-CurrentAppConfig {
    Param(
        [Parameter(Mandatory)]
        [string]$ProfilePath
    )
    Get-Content -Path $ProfilePath -Raw | ConvertFrom-Json
}