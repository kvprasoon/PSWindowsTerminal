Get-ChildItem -Path $PSScriptRoot\..\PSWindowsTerminal\Private | ForEach-Object -Process {
    . $_.FullName
}

$ExceptionList = Import-PowerShellDataFile -Path $PSScriptRoot\..\PSWindowsTerminal\Configs\Exceptions.psd1

Describe "Unit tests for private functions" -Tag "UnitTest" {
    Context "Tests for CheckPath function" {
        it "Should throw specific message if path is not available" {
            $InvalidPath = 'TestDrive:\WrongPath'
            $ExpedtedMessage = $ExceptionList.FileNotFound -f $InvalidPath

            Mock Test-Path -MockWith { $False }

            { CheckPAth -Path $InvalidPath } | Should -Throw -ExpectedMessage $ExpedtedMessage
        }

        it "Should not throw if path is available" {
            Mock Test-Path -MockWith { $True }

            { CheckPAth -Path 'TestDrive:\' } | Should -Not -Throw
        }
    }

    Context "Tests for Get-CurrentAppConfig function" {
        BeforeAll {
            $ProfilePath = 'TestDrive:\Profile.json'
        }
        it "Gets the WindowsTerminal Configuration" {
            $ExpectedConfig = [PSCustomObject]@{
                Profiles = @(@{
                        backgroundImage = 'TestDrive:\Image.gif'
                    })
            }
            Mock Get-Content -MockWith { $ExpectedConfig | ConvertTo-Json }
            Get-CurrentAppConfig -ProfilePath $ProfilePath | Should -Not -BeNullOrEmpty
        }

        it "Throws error when Get-Content throws exception" {
            $ErrorMessage = "Some Error"
            Mock Get-Content -MockWith { Throw $ErrorMessage }
            { Get-CurrentAppConfig -ProfilePath $ProfilePath } | Should -Throw -ExpectedMessage $ErrorMessage
        }
    }
}
