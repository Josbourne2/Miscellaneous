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

New-Item -ItemType Directory -Force -Path D:\Data
New-Item -ItemType Directory -Force -Path D:\Software
New-Item -ItemType Directory -Force -Path D:\GoogleDrive

#Disable User Account Control
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 

#Get chocolatey
Set-ExecutionPolicy Bypass -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install sql-server-2017 --params="'/INSTANCEDIR=D:\Data\MSSQLSERVER /INDICATEPROGRESS'" -y
choco install sql-server-management-studio -y
choco install visualstudio2019community -y
choco install notepadplusplus.install -y
choco install googlechrome -y
choco install adblockpluschrome -y
choco install adobereader -y
choco install jre8 -y
choco install git.install -y
choco install putty.install -y
choco install sysinternals -y
choco install filezilla -y
choco install teamviewer -y
choco install vscode -y
choco install vscode-powershell -y
choco install vscode-csharp -y
choco install vscode-mssql -y
choco install vscode-gitattributes -y
choco install winmerge -y
choco install ssis-vs2019 -y
choco install crystaldiskmark -y
choco install sqlsearch -y
choco install sqlsentryplanexplorer -y
choco install azure-data-studio -y
choco install powerbi -y
#choco install docker-desktop -y
choco install github-desktop -y
#choco install gitkraken 
#choco install python3 -y
#choco install sql-server-express -y
#choco install sqltoolbelt -Y
choco install microsoft-teams -y
#choco install slack -y
choco install minikube -y
choco install kubernetes-helm -y
choco install kubernetes-cli -y
choco install microsoftazurestorageexplorer -y
choco install nodejs.install -y
choco install r.project -y
choco install r.studio -y
choco install awscli -y
choco install markdownmonster -y
choco install paint.net -y
choco install nuget.commandline -y
choco install curl -y
choco install cpu-z -y
choco install treesizefree -y
choco install azure-cli -y
choco install poshgit -y
choco install git-credential-manager-for-windows -y
choco install rdcman -y
choco install spotify -y
#choco install office365proplus -y
choco install pester -y
#choco install docker-cli -y
#choco install lastpass -y
choco install whatsapp -y
#choco install google-drive-file-stream -y #alleen met business account
choco install google-backup-and-sync -y
#choco install visualstudio2019sql -y #werkt nog niet met de release versie
choco install lightshot.install -y
#https://chocolatey.org/packages/chocolatey-visualstudio.extension
