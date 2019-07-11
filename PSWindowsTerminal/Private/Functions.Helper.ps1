Function CheckPath {
    Param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (-not (Test-Path -Path $Path)) {
        Throw ($Script:ExceptionList.PathNotFound -f $Path)
    }
}

Function Get-CurrentAppConfig {
    Param(
        [Parameter(Mandatory)]
        [string]$ProfilePath
    )
    Get-Content -Path $ProfilePath -Raw | ConvertFrom-Json
}