<#
FWVMUG Testing Infrastructure with Pester
Windows_Infrastructure_Example.tests.ps1

Description:
This script uses the Pester Framework to test infrastructure.

Purpose: 
This Pester test verifies that all critical services
are in their correct state. Treat this test as a continuous 
work in progress, adding additional tests as needed. 
#>

Describe -Name 'Contoso Windows Service Infrastructure' -Tag 'UAT' {

    Context -Name 'Service Checks' {

        It -Name 'BITS is running on 0XXDC01.kindlelan.local' {

            $comp = '0XXDC01.kindlelan.local'
            $Svc = Get-Service -ComputerName $comp -Name 'BITS'

            $Svc.Status | Should -BeExactly 'Running'

        }

    }

}

Describe -Name 'Contoso IIS Infrastructure' -Tag 'UAT' {

    Context -Name 'UAT Application Pool Checks' {

        It -Name 'Kindle Application Pool is Started' {

            $comp = '0XXIIS01.kindlelan.local'

            $AppStatus = Invoke-Command -ComputerName $comp -ScriptBlock {

                Get-WebAppPoolState  -Name 'KindleAppPool'

            }

            $AppStatus.Value | Should -BeExactly 'Started'

        }

    }

}

Describe -Name 'Contoso Windows Service Infrastructure' -Tag 'Prod' {

    Context -Name 'Service Checks' {

        It -Name 'BITS is running' {

            $comp = '0XXDC01.kindlelan.local'
            $Svc = Get-Service -ComputerName $comp -Name 'BITS'

            $Svc.Status | Should -BeExactly 'Running'

        }

    }

}

Describe -Name 'Contoso IIS Infrastructure' -Tag 'Prod' {

    Context -Name 'Application Pool Checks' {

        It -Name 'DocServer Application Pool is Started' {

            $comp = '0XX.kindlelan.local'

            $AppStatus = Invoke-Command -ComputerName $comp -ScriptBlock {

                Get-WebAppPoolState  -Name 'DocServerAppPool'

            }

            $AppStatus.Value | Should -BeExactly 'Started'

        }

    }

}

Describe -Name 'Google Search Status' -Tag 'Prod' {

    It 'http://www.google.com/ is Available' {

        $URL = Invoke-WebRequest -Uri 'http://www.google.com/'

        $URL.StatusCode | Should -BeExactly '200'

    }

}