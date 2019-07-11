Function Set-WTBackgroundImage {
    [Alias("wtimg")]
    Param(
        [Parameter(Mandatory)]
        [string]$ImagePath
    )

    $ProfilePath = WindowsTerminalLocation
    $CurrentExec = [System.IO.Path]::GetFileNameWithoutExtension([Environment]::GetCommandLineArgs())
    CheckPath -Path $ImagePath
    $Config = Get-CurrentAppConfig
    $CurrentAppConfig = $Config.Profiles | Where-Object -FilterScript {[System.IO.Path]::GetFileNameWithoutExtension($_.CommandLine) -eq $CurrentExec }

    if($CurrentAppConfig.BackgroundImage){
        $CurrentAppConfig.BackgroundImage = $ImagePath
    }
    else{
        $CurrentAppConfig | Add-Member -MemberType NoteProperty -Name backgroundImage -Value $ImagePath -Force
    }

    $Config | ConvertTo-Json -Depth 99 | Out-File -FilePath $ProfilePath -Force -Encoding utf8
}
