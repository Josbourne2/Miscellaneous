####### IMPORTANT ########
#This script should be run as Administrator
#Before execution you should enable the running of scripts: type the following line in another Powershell session (as Administrator):

#Set-ExecutionPolicy RemoteSigned 

#Restarts happen automatically: after a restart this script needs to be restarted manually
#You can restart the script from the top
#This script is almost unattended: this means that you need to stick around to click "Yes" or "Next" a few times..
#This is true for the Visual Studio extensions that are downloaded using Invoke-Webrequest, somewhere around line 65 of this script..
#This will be after 30-60 minutes into the script..

#Enter your desired folder paths. Or directory paths if you're old like me..
$dataFolderPath = "D:\Data"
$softwareFolderPath = "D:\Software"
$googleDriveFolderPath = "D:\GoogleDrive"

#Configure required modules and functions

Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted 
Install-Module PendingReboot
function RestartIfNeeded()
{
    if ((Test-PendingReboot).IsRebootPending) 
    {        
        Restart-Computer         
    }
}
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
New-Item -ItemType Directory -Force -Path $dataFolderPath
New-Item -ItemType Directory -Force -Path $softwareFolderPath
New-Item -ItemType Directory -Force -Path $googleDriveFolderPath

#Disable User Account Control
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 

#Get chocolatey
Set-ExecutionPolicy Bypass -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
Set-Variable "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RestartIfNeeded
#SQL Server 2019 Developer edition and tools
choco install sql-server-2019 --params="'/INSTANCEDIR=$dataFolderPath\MSSQLSERVER /INDICATEPROGRESS'" -y
choco install sql-server-management-studio -y
choco install sqlsearch -y
#choco install sqlsentryplanexplorer -y #Broken, new download link is https://downloads.sentryone.com/downloads/sqlsentryplanexplorer/x64/PlanExplorerInstaller.exe
choco install azure-data-studio -y

RestartIfNeeded
#Visual Studio and workloads
choco install visualstudio2019professional -y
choco install visualstudio2019-workload-manageddesktop -y
choco install visualstudio2019-workload-data -y
choco install visualstudio2019-workload-netweb -y
choco install visualstudio2019-workload-node -y
choco install visualstudio2019-workload-netcrossplat -y
choco install ssis-vs2019 -y
choco install dotnetcore-sdk -y


RestartIfNeeded

#Other tools
choco install soapui -y
choco install postman -y
choco install notepadplusplus.install -y
choco install nodejs-lts -y 
choco install git -y
choco install cmder -y
#choco install googlechrome -y
choco install microsoft-edge -y
#choco install adblockpluschrome -y
choco install adobereader -y
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
choco install paint.net -y
choco install curl -y
choco install cpu-z -y
choco install treesizefree -y
choco install azure-cli -y
#choco install poshgit -y #Already included with the cmder package.
choco install git-credential-manager-for-windows -y
choco install mremoteng -y
choco install spotify -y
choco install office365proplus -y
choco install whatsapp -y
#choco install google-drive-file-stream -y #Only when you are using a Google business account
choco install google-backup-and-sync -y #For "normal" people :-)
choco install lightshot.install -y
#https://chocolatey.org/packages/chocolatey-visualstudio.extension
choco install calibre -y #An ebook tool + reader for managing your ereader
choco install 7zip -y
choco install keepass -y
#Download and install VS extensions
#BimlExpress plugin
Invoke-WebRequest -Uri https://www.varigence.com/downloads/bimlexpress.vsix -OutFile "$softwareFolderPath\bimlexpress.vsix"
Invoke-Expression ($softwareFolderPath+"\bimlexpress.vsix")
#VS Web Essentials 2019
Invoke-WebRequest -Uri http://vsixgallery.com/extensions/509fc133-d9a6-4cf7-a558-e00fd11e0f9f/Web%20Essentials%202019%20v0.5.10.vsix -OutFile "$softwareFolderPath\WebEssentials2019.vsix"
Invoke-Expression ($softwareFolderPath+"\WebEssentials2019.vsix")
Invoke-WebRequest -Uri https://www.apexsql.com/zips/ApexSQLRefactor.exe -OutFile "$softwareFolderPath\ApexSQLRefactor.exe"
Invoke-Expression ($softwareFolderPath+"\ApexSQLRefactor.exe")
Invoke-WebRequest -Uri https://www.apexsql.com/zips/ApexSQLComplete.exe -OutFile "$softwareFolderPath\ApexSQLComplete.exe"
Invoke-Expression ($softwareFolderPath+"\ApexSQLComplete.exe")
