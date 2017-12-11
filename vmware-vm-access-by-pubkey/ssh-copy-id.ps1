Write-Host "This script adds your public key to multiple remote VMs"
Write-Host "*VMs must have identical root password"
$vCenter= Read-Host -Prompt 'vCenter address'
$vUser = Read-Host -Prompt 'vCenter Username'
$pass = Read-Host -Prompt 'vCenter Pass'
$vPass = ConvertTo-SecureString -String $pass -AsPlainText -Force
$vCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $vUser, $vPass

###### move to included files 
function Change-TitleBar() {
    ## check to see if there are any currently connected servers
    if ($global:DefaultVIServers.Count -gt 0) {
        ## since there is at least one connected server, modify the window title variable accordingly
        $strWindowTitle = "[PowerCLI] Connected to {0} server{1}:  {2}" -f $global:DefaultVIServers.Count, $(if ($global:DefaultVIServers.Count -gt 1) {"s"}), (($global:DefaultVIServers | %{$_.Name}) -Join ", ")
    }
    else {
        ## since there are no connected servers, modify the window title variable to show "not connected"
        $strWindowTitle = "[PowerCLI] Not Connected"
    }
    ## perform the window title change
    $host.ui.RawUI.WindowTitle = $strWindowTitle
}
###### move to included files
Change-TitleBar

$HostSource = Read-Host -Prompt 'VM-location (ESX host)'
Write-Host "Enter ESX host root passw:"
$hc = Get-Credential -Credential 'root'
Write-Host "Enter VM root passw:"
$gc = Get-Credential -Credential 'root'
$namePattern = Read-Host -Prompt 'VM-name or regexp'
$PublicKey = Read-Host -Prompt 'copy your id_rsa.pub:'

if ($global:DefaultVIServers.Count -lt 1) {
    Connect-ViServer $vCenter -Credential $vCredential -force
}
Change-TitleBar

$update = "echo '$PublicKey' >> /root/.ssh/authorized_keys"

$VMs = Get-VM -Location $HostSource -Name $namePattern | Where-Object {$_.powerstate -eq 'PoweredOn'} | Sort-Object -Property Name
#Check vmtools and network
foreach($item in $VMs){ 
	$guest = (Get-VM $item | Get-View).Guest.GuestFamily
    if($guest -eq 'linuxGuest') {
        Write-Host "Adding id_rsa.pub on $item" -fore Yellow 
        $item | Invoke-VMScript -HostCredential $hc -GuestCredential $gc $update
    }
}