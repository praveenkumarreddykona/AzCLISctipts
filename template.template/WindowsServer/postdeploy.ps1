
param([string]$DNS) 

Function New-RegKey {
    param (
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]$Path,
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]$Name,
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]$Value,
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]$Type
    )
    IF (!(Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
    }
    ELSE {
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
    }
}
function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    #Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}
function Enable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 1
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 1
    #Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been enabled." -ForegroundColor Green
}
function Disable-UserAccessControl {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    
}

#New-RegKey -Path HKLM:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -Type DWORD -Value "0x1"

#Disable UAC and IE enhanced security
#Disable-UserAccessControl
#Disable-InternetExplorerESC

if ($DNS -ne "") {
    Write-Host "Reset DNS = '$DNS'" 
    Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter -physical).ifIndex[0] -ServerAddresses( $DNS )
}
else {
    Write-Host "no need to reset DNS. " 
