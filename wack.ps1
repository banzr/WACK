# WACK

echo "Windows Automated Configuration Kickbutt! (WACK) 1.0"
echo "Author: Andrew Singley"
echo "This product has no association with Microsoft Corp."
echo ""

echo "Enabling WSL Windows Subsystem for Linux..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
echo "Enabled WSL Windows Subsystem for Linux."

# Lists all installed packages F.Y.I.
# Get-AppxPackage -allusers | Select Name, PackageFullName

# Install Chocolatey
echo "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
echo "Installed Chocolatey."


### Remove garbage

echo "Removing Bloatware..."

#3D Builder: 
Get-AppxPackage *3dbuilder* | Remove-AppxPackage

#Alarms and Clock: 
Get-AppxPackage *windowsalarms* | Remove-AppxPackage

#NOT Calculator: Get-AppxPackage *windowscalculator* | Remove-AppxPackage

#Calendar and Mail: 
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage

#Camera: 
Get-AppxPackage *windowscamera* | Remove-AppxPackage

#Get Office: 
Get-AppxPackage *officehub* | Remove-AppxPackage

#Get Skype: 
Get-AppxPackage *skypeapp* | Remove-AppxPackage

#Get Started: 
Get-AppxPackage *getstarted* | Remove-AppxPackage

#Groove Music: 
Get-AppxPackage *zunemusic* | Remove-AppxPackage

#Maps: 
Get-AppxPackage *windowsmaps* | Remove-AppxPackage

#Microsoft Solitaire Collection: 
Get-AppxPackage *solitairecollection* | Remove-AppxPackage

#Money: 
Get-AppxPackage *bingfinance* | Remove-AppxPackage

#Movies & TV: 
Get-AppxPackage *zunevideo* | Remove-AppxPackage

#News: 
Get-AppxPackage *bingnews* | Remove-AppxPackage

#OneNote: 
Get-AppxPackage *onenote* | Remove-AppxPackage


#Phone Companion: 
Get-AppxPackage *windowsphone* | Remove-AppxPackage

#NOT Photos: Get-AppxPackage *photos* | Remove-AppxPackage

#NOT Store: Get-AppxPackage *windowsstore* | Remove-AppxPackage

#Sports: 
Get-AppxPackage *bingsports* | Remove-AppxPackage

#Voice Recorder: 
Get-AppxPackage *soundrecorder* | Remove-AppxPackage

#NOT Weather: Get-AppxPackage *bingweather* | Remove-AppxPackage

#Xbox: 
Get-AppxPackage *xboxapp* | Remove-AppxPackage

#3DViewer
Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage

#Messaging
Get-AppxPackage *Messaging* | Remove-AppxPackage

#OneConnect
Get-AppxPackage *OneConnect* | Remove-AppxPackage

#Print3d
Get-AppxPackage *Print3D* | Remove-AppxPackage

#Wallet
Get-AppxPackage *Wallet* | Remove-AppxPackage

#FeedbackHub
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage

#Phone
Get-AppxPackage *YourPhone* | Remove-AppxPackage

# Movies
Get-AppxPackage *ZuneVideo*| Remove-AppxPackage

#Fitbit
Get-AppxPackage *Fitbit* | Remove-AppxPackage

#Bloat
Get-AppxPackage *ThumbmunkeysLtd* | Remove-AppxPackage

Get-AppxPackage *CandyCrushSaga*| Remove-AppxPackage
Get-AppxPackage *Friends*| Remove-AppxPackage


#MixedReality
Get-AppxPackage *MixedReality*| Remove-AppxPackage

echo "Removed Bloatware."

#TODO Install Debian APP:
# TheDebianProject.DebianGNULinux


echo "Installing Choco Apps..."

cinst -y `
	jetbrainstoolbox `
	googlechrome `
	firefox `
	python `
	filezilla `
	jdk11 `
	discord `
	vlc `
	7zip `
	notepadplusplus `
	vscode `
	steam `
	krita `
	msys2 `
	ruby `
	haskell-stack `
	bazel `
	git.install `
	nodejs.install `
	putty.install `
	ccleaner `
	spybot `
	vcredist140 `
	wget `
	atom `
	strawberryperl `
	libreoffice `
	origin `
	goggalaxy `
	elixir `
	rust `
	etcher `
	virtualbox `
	postgresql `
	pgadmin4

echo "Installed Choco Apps."


############# Disable People in Taskbar ############
echo "Removing People from Taskbar"

$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"

$Name = "Version"

$value = "0"

IF(!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
echo "Removed People from Taskbar"


## ==============================================
## Show Desktop Icons
##
## -- For "My Computer" Icon ----- "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
## -- For "Control Panel" Icon ----- "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}"
## -- For "Recycle Bin" Icon ----- "{645FF040-5081-101B-9F08-00AA002F954E}"
## -- For "User File" Icon ----- "{59031a47-3f72-44a7-89c5-5595fe6b30ee}"
## -- For "Network" Icon ----- "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}"
##
## ==============================================
echo "Adding My Computer to Desktop"

$ErrorActionPreference = "SilentlyContinue"
If ($Error) {$Error.Clear()}
$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
If (Test-Path $RegistryPath) {
	$Res = Get-ItemProperty -Path $RegistryPath -Name "HideIcons"
	If (-Not($Res)) {
		New-ItemProperty -Path $RegistryPath -Name "HideIcons" -Value "0" -PropertyType DWORD -Force | Out-Null
	}
	$Check = (Get-ItemProperty -Path $RegistryPath -Name "HideIcons").HideIcons
	If ($Check -NE 0) {
		New-ItemProperty -Path $RegistryPath -Name "HideIcons" -Value "0" -PropertyType DWORD -Force | Out-Null
	}
}
$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons"
If (-Not(Test-Path $RegistryPath)) {
	New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "HideDesktopIcons" -Force | Out-Null
	New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons" -Name "NewStartPanel" -Force | Out-Null
}
$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
If (-Not(Test-Path $RegistryPath)) {
	New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons" -Name "NewStartPanel" -Force | Out-Null
}
If (Test-Path $RegistryPath) {
	## -- My Computer
	$Res = Get-ItemProperty -Path $RegistryPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
	If (-Not($Res)) {
		New-ItemProperty -Path $RegistryPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value "0" -PropertyType DWORD -Force | Out-Null
	}
	$Check = (Get-ItemProperty -Path $RegistryPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}")."{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
	If ($Check -NE 0) {
		New-ItemProperty -Path $RegistryPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value "0" -PropertyType DWORD -Force | Out-Null
	}
}
If ($Error) {$Error.Clear()}

echo "Added My Computer to Desktop"


########## Windows Update ###############
echo "Running Windows Updates"
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate
echo "Completed Windows Updates"



echo " Verify Removing Bloatware..."

#3D Builder: 
Get-AppxPackage *3dbuilder* | Remove-AppxPackage

#Alarms and Clock: 
Get-AppxPackage *windowsalarms* | Remove-AppxPackage

#NOT Calculator: Get-AppxPackage *windowscalculator* | Remove-AppxPackage

#Calendar and Mail: 
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage

#Camera: 
Get-AppxPackage *windowscamera* | Remove-AppxPackage

#Get Office: 
Get-AppxPackage *officehub* | Remove-AppxPackage

#Get Skype: 
Get-AppxPackage *skypeapp* | Remove-AppxPackage

#Get Started: 
Get-AppxPackage *getstarted* | Remove-AppxPackage

#Groove Music: 
Get-AppxPackage *zunemusic* | Remove-AppxPackage

#Maps: 
Get-AppxPackage *windowsmaps* | Remove-AppxPackage

#Microsoft Solitaire Collection: 
Get-AppxPackage *solitairecollection* | Remove-AppxPackage

#Money: 
Get-AppxPackage *bingfinance* | Remove-AppxPackage

#Movies & TV: 
Get-AppxPackage *zunevideo* | Remove-AppxPackage

#News: 
Get-AppxPackage *bingnews* | Remove-AppxPackage

#OneNote: 
Get-AppxPackage *onenote* | Remove-AppxPackage


#Phone Companion: 
Get-AppxPackage *windowsphone* | Remove-AppxPackage

#NOT Photos: Get-AppxPackage *photos* | Remove-AppxPackage

#NOT Store: Get-AppxPackage *windowsstore* | Remove-AppxPackage

#Sports: 
Get-AppxPackage *bingsports* | Remove-AppxPackage

#Voice Recorder: 
Get-AppxPackage *soundrecorder* | Remove-AppxPackage

#NOT Weather: Get-AppxPackage *bingweather* | Remove-AppxPackage

#Xbox: 
Get-AppxPackage *xboxapp* | Remove-AppxPackage

#3DViewer
Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage

#Messaging
Get-AppxPackage *Messaging* | Remove-AppxPackage

#OneConnect
Get-AppxPackage *OneConnect* | Remove-AppxPackage

#Print3d
Get-AppxPackage *Print3D* | Remove-AppxPackage

#Wallet
Get-AppxPackage *Wallet* | Remove-AppxPackage

#FeedbackHub
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage

#Phone
Get-AppxPackage *YourPhone* | Remove-AppxPackage

# Movies
Get-AppxPackage *ZuneVideo*| Remove-AppxPackage

#Fitbit
Get-AppxPackage *Fitbit* | Remove-AppxPackage

#Bloat
Get-AppxPackage *ThumbmunkeysLtd* | Remove-AppxPackage

Get-AppxPackage *CandyCrushSaga*| Remove-AppxPackage
Get-AppxPackage *Friends*| Remove-AppxPackage


#MixedReality
Get-AppxPackage *MixedReality*| Remove-AppxPackage



echo "Bloatware Removed."



echo "End of script"


