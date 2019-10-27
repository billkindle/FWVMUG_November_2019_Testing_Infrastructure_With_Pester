<#
Infrastructure Testing with Pester
Pester_Basic_Structure_Syntax.ps1

Author: Bill Kindle
For: Fort Wayne Vmware User Group (VMUG)
Date: November 2019

Description:
The example below was used as an overview of the basic 
syntax used for creating effective Pester tests for 
infrastructure using PowerShell and Vmware PowerCli.
#>


# This is a basic example of a Pester test

# Green = Pass / Good
# Red = Fail / Bad

# A Describe block declares a group of tests. You can also use a tag parameter.
Describe 'My group of tests' -Tag 'AppTests' {

    # A context block declares a single or a set of tests grouped by scope
    Context 'My set of tests for a particular scope' {

        # The It block declares an assertion. 
        It 'My test description Pass' {

            # Here we just use PowerShell / PowerCLI cmdlets to complete our test assertion(s)
            $Svc = (Get-Service -ServiceName 'BITS')

            # By making our PowerShell code a variable, we can now access all the membertypes available
            # and have a single, boolean value to test against.
            $Svc.Status | Should -BeExactly 'Running' # Here, Running is the 'True', or expected value.

        }
        
        It 'My test description Fail' {

            # Here we just use PowerShell / PowerCLI cmdlets to complete our test assertion(s)
            $Svc = (Get-Service -ServiceName 'BITS')

            # By making our PowerShell code a variable, we can now access all the membertypes available
            # and have a single, boolean value to test against.
            $Svc.Status | Should -BeExactly 'Stopped' # Here, Stopped is the 'False', or expected value.

        }
        
    }

}