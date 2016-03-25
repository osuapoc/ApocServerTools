@echo off
set pboConsolePath=C:\Program Files\PBO Manager v.1.4 beta

set stagingPath=C:\ARMA Editing\ExileMod\_VersionControlled\Staging
set versionControlPath=C:\ARMA Editing\ExileMod\_VersionControlled\Mayhem.Exile.Altis
set testServerPath=G:\A3 Test Server

taskkill /f /im arma3server.exe

cd "%testServerPath%"
timeout 1
start "arma3" /min "%testServerPath%\arma3server.exe" -port=2302 -autoinit "-config=_Exile\config.cfg" "-cfg=_Exile\basic.cfg" "-profiles=_Exile" "-name=_Exile"  -servermod=@ExileServer -mod=@Exile 
::timeout 10
echo ARMA 3 Server has started
timeout 2
exit
