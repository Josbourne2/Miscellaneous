####### IMPORTANT ########
#This script should be run as Administrator
#Before execution you should enable the running of scripts: type the following line in another Powershell session (as Administrator):

Set-ExecutionPolicy RemoteSigned 

#Restarts happen automatically: after a restart this script needs to be restarted manually
#You can restart the script from the top
#This script is almost unattended: this means that you need to stick around to click "Yes" or "Next" a few times..
#This is true for the Visual Studio extensions that are downloaded using Invoke-Webrequest, somewhere around line 65 of this script..
#This will be after 30-60 minutes into the script..

#Enter your desired folder paths. Or directory paths if you're old like me..
$dataFolderPath = "D:\Data"
$softwareFolderPath = "D:\Software"

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
#New-Item -ItemType Directory -Force -Path $googleDriveFolderPath

#Disable User Account Control
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 

#Get chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Set-Variable "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RestartIfNeeded
#SQL Server 2022 Developer edition and tools
choco install sql-server-2022 --params="'/INSTANCEDIR=$dataFolderPath\MSSQLSERVER /INDICATEPROGRESS'" -y
choco install sql-server-management-studio -y
#choco install sqlsentryplanexplorer -y #Broken, new download link is https://downloads.sentryone.com/downloads/sqlsentryplanexplorer/x64/PlanExplorerInstaller.exe
#choco install azure-data-studio -y

RestartIfNeeded
#Visual Studio and workloads
choco install visualstudio2022enterprise -y
choco install visualstudio2022-workload-manageddesktop -y
choco install visualstudio2022-workload-data -y
choco install visualstudio2022-workload-netweb -y
#choco install visualstudio2022-workload-node -y
choco install visualstudio2022-workload-azure -y
choco install visualstudio2022-workload-netcrossplat -y
choco install visualstudio2022-workload-universal -y
choco install dotnet-8.0-sdk -y
choco install dotnet-sdk -y
RestartIfNeeded

#Old .NET versions to support older code
choco install dotnet4.5 -y
choco install netfx-4.5.1-devpack -y
choco install netfx-4.5.2-devpack -y
choco install netfx-4.6-devpack -y
choco install netfx-4.6.1-devpack -y
choco install netfx-4.7.2-devpack -y
choco install netfx-4.8-devpack -y

#Docker desktop and prerequisites
#Comment out wsl install command after first install, otherwise it starts up the ubuntu shell on the second run making the install process seem to hang
wsl --install
choco install docker-desktop -y
RestartIfNeeded

#Other tools
choco install javaruntime -y
choco install nswagstudio -y
choco install soapui -y
choco install postman -y
choco install notepadplusplus.install -y
choco install nodejs-lts -y 
choco install git -y
choco install cmder -y
choco install googlechrome -y
#choco install microsoft-edge -y
choco install adblockpluschrome -y
choco install adobereader -y
choco install sysinternals -y
choco install filezilla -y
choco install teamviewer -y
choco install vscode -y
choco install vscode-powershell -y
choco install vscode-csharp -y
choco install vscode-mssql -y
choco install vscode-gitattributes -y
choco install vscode-java -y
choco install vscode-gitlens -y
choco install vscode-prettier -y

choco install crystaldiskmark -y
#choco install powerbi -y
choco install github-desktop -y
#choco install microsoft-teams -y
choco install microsoftazurestorageexplorer -y
choco install paint.net -y
choco install curl -y
choco install cpu-z -y
choco install treesizefree -y
choco install azure-cli -y

choco install git-credential-manager-for-windows -y
choco install mremoteng -y
choco install spotify -y
choco install office365business -y
choco install whatsapp -y
choco install lightshot.install -y
#https://chocolatey.org/packages/chocolatey-visualstudio.extension
choco install calibre -y #An ebook tool + reader for managing your ereader
choco install 7zip -y
choco install keepass -y
choco install ServiceBusExplorer -y


Invoke-WebRequest -Uri https://downloads.solarwinds.com/solarwinds/Release/FreeTool/SolarWinds-PlanExplorer.exe -OutFile "$softwareFolderPath\PlanExplorerInstaller.exe"
Invoke-Expression ($softwareFolderPath+"\PlanExplorerInstaller.exe")
