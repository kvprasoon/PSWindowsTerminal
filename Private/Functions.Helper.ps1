Function CheckPath {
    Param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if(-not (Test-Path -Path $Path)){
        Throw "$Path is not available, please provide a valid path."
    }
}