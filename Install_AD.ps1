Install-windowsfeature -name AD-Domain-Services 
Install-windowsfeature -name IncludeManagementTools
Add-WindowsFeature -Name AD-Domain-Services, DHCP, DNS



# ADDSDEPLOYEMENT

Import-Module ADDSDeployment
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "WinThreshold" `
    -DomainName "BillU.lan" `
    -DomainNetbiosName "BILLU" `
    -ForestMode "WinThreshold" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true

# Configure DHCP scope
Add-DhcpServerv4Scope -Name "SCOPE1" -StartRange 192.168.2.1 -EndRange 192.168.2.254 -SubnetMask 255.255.255.0

# Configure DNS forwarders
Add-DnsServerForwarder -IPAddress 192.168.2.2