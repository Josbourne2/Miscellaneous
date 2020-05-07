function ShowFileExtensions()
{
    # http://superuser.com/questions/666891/script-to-set-hide-file-extensions
    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . HideFileExt "0"
    Pop-Location
    Stop-Process -processName: Explorer -force # This will restart the Explorer service to make this work.
}
 
ShowFileExtensions

#Create default folders
New-Item -ItemType Directory -Force -Path D:\Data
New-Item -ItemType Directory -Force -Path D:\Software
New-Item -ItemType Directory -Force -Path D:\GoogleDrive

#Disable User Account Control
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 

#Get chocolatey
Set-ExecutionPolicy Bypass -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

#SQL Server 2017 Developer edition and tools
choco install sql-server-2019 --params="'/INSTANCEDIR=D:\Data\MSSQLSERVER /INDICATEPROGRESS'" -y
choco install sql-server-management-studio -y
choco install sqlsearch -y
choco install sqlsentryplanexplorer -y
choco install azure-data-studio -y

#Visual Studio and workloads
choco install visualstudio2019professional -y
choco install visualstudio2019-workload-manageddesktop -y
choco install visualstudio2019-workload-data -y
choco install visualstudio2019-workload-netweb -y
choco install visualstudio2019-workload-node -y
choco install visualstudio2019-workload-netcoretools -y
choco install visualstudio2019-workload-netcrossplat -y
choco install ssis-vs2019 -y
choco install dotnetcore-sdk -y

#Download and install VS extensions
#BimlExpress plugin
Invoke-WebRequest -Uri https://www.varigence.com/downloads/bimlexpress.vsix -OutFile "D:\Software\bimlexpress.vsix"
D:\Software\bimlexpress.vsix
#VS Web Essentials 2019
Invoke-WebRequest -Uri http://vsixgallery.com/extensions/509fc133-d9a6-4cf7-a558-e00fd11e0f9f/Web%20Essentials%202019%20v0.5.10.vsix -OutFile "D:\Software\WebEssentials2019.vsix"
D:\Software\WebEssentials2019.vsix

#Other tools
choco install soapui -y
choco install postman -y
choco install notepadplusplus.install -y
choco install cmder -y
choco install googlechrome -y
choco install adblockpluschrome -y
choco install adobereader -y
choco install git -y
choco install sysinternals -y
choco install filezilla -y
choco install teamviewer -y
choco install vscode -y
choco install vscode-powershell -y
choco install vscode-csharp -y
choco install vscode-mssql -y
choco install vscode-gitattributes -y
choco install crystaldiskmark -y
choco install powerbi -y
choco install github-desktop -y
choco install microsoft-teams -y
choco install microsoftazurestorageexplorer -y
choco install nodejs.install -y
choco install paint.net -y
choco install nuget.commandline -y
choco install curl -y
choco install cpu-z -y
choco install treesizefree -y
choco install azure-cli -y
#choco install poshgit -y komt al mee met cmder
choco install git-credential-manager-for-windows -y
choco install mremoteng -y
choco install spotify -y
choco install office365proplus -y
#choco install pester -y
#choco install docker-cli -y
#choco install lastpass -y
choco install whatsapp -y
#choco install google-drive-file-stream -y #alleen met business account
choco install google-backup-and-sync -y
choco install lightshot.install -y
#https://chocolatey.org/packages/chocolatey-visualstudio.extension
choco install calibre -y
