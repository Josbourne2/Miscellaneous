$softwareFolderPath = "D:\Software"
#Invoke-WebRequest -Uri https://www.apexsql.com/zips/ApexSQLRefactor.exe -OutFile "$softwareFolderPath\ApexSQLRefactor.exe"
#Invoke-Expression ($softwareFolderPath+"\ApexSQLRefactor.exe")
Invoke-WebRequest -Uri https://www.apexsql.com/zips/ApexSQLComplete.exe -OutFile "$softwareFolderPath\ApexSQLComplete.exe"
Invoke-Expression ($softwareFolderPath+"\ApexSQLComplete.exe")