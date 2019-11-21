# This is a demo of Pester Infrastructure Testing on Linux

Describe -Name 'Local Service Testing' {
        Context -Name 'Network Services' {
                It -Name 'network-online.target is active' {
                        <# 
                        Here we are assigning a variable to some basic BASH commands
                        that will return a single value based on exit codes. 
                        For more information, 
                        https://www.commandlinux.com/man-page/man1/systemctl.1.html
                        #>
                        $NetSvc = (systemctl is-active network-online.target)
                        $NetSvc | Should -Be 'active'
                }
                It -Name 'firewalld.service is active' {
                        $FwSvc = (systemctl is-active firewalld.service)
                        $FwSvc | Should -Be 'active'
                }
        }
        Context -Name 'System Services' {
                It -Name 'KDump is active' {
                        $KdmpSvc = (systemctl is-active kdump.service)
                        <#
                        This test should fail because this service is NOT active.
                        During my presentation I mentioned some nuances with building 
                        pester tests. You could make this test pass by simply changing 
                        'active' to 'failed', and since the service is 'failed' becuase
                        it's not running, the test would pass. You could also change the 
                        Should switch '-Be' to '-Not -Be'. 
                        #>
                        $KdmpSvc | Should -Be 'active'
                }
        }
}
