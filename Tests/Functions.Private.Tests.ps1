Get-ChildItem -Path $PSScriptRoot\..\Private | ForEach-Object -Process {
    . $_.FullName
}

$ExceptionList = Import-PowerShellDataFile -Path $PSScriptRoot\..\Configs\Exceptions.psd1

Describe "Unit tests for private functions" -Tag "UnitTest" {
    Context "Tests for CheckPath function" {
        it "Should throw specific message if path is not available" {
            $InvalidPath     = 'TestDrive:\WrongPath'
            $ExpedtedMessage = $ExceptionList.FileNotFound -f $InvalidPath

            Mock Test-Path -MockWith {$False}

            {CheckPAth -Path $InvalidPath} | Should -Throw -ExpectedMessage $ExpedtedMessage
        }

        it "Should not throw if path is available" {
            Mock Test-Path -MockWith {$True}

            {CheckPAth -Path 'TestDrive:\'} | Should -Not -Throw
        }
    }
}