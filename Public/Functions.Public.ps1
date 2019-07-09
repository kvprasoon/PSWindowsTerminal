Function Set-WTBackgroundImage {
    [Alias("wtimg")]
    Param(
        [string]$ProfilePath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal*\RoamingState\profiles.json",

        [Parameter(Mandatory)]
        [string]$ImagePath
    )

    CheckPath -Path $ImagePath

    $CurrentExec = [System.IO.Path]::GetFileNameWithoutExtension([Environment]::GetCommandLineArgs())
    $Config      = Get-Content -Path $ProfilePath -Raw | ConvertFrom-Json
    $CurrentAppConfig = $Config.Profiles | Where-Object -FilterScript {[System.IO.Path]::GetFileNameWithoutExtension($_.CommandLine) -eq $CurrentExec }
    if($CurrentAppConfig.BackgroundImage){
        $CurrentAppConfig.BackgroundImage = $ImagePath
    }
    else{
        $CurrentAppConfig | Add-Member -MemberType NoteProperty -Name backgroundImage -Value $ImagePath -Force
    }

    $Config | ConvertTo-Json -Depth 99 | Out-File -FilePath $ProfilePath -Force -Encoding utf8
}
