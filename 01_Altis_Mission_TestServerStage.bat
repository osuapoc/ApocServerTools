@echo off
set pboConsolePath=C:\Program Files\PBO Manager v.1.4 beta

set stagingPath=C:\ARMA Editing\ExileMod\_VersionControlled\Staging
set versionControlPath=C:\ARMA Editing\ExileMod\_VersionControlled\Mayhem.Exile.Altis
set testServerPath=G:\A3 Test Server

::Delete Already staged files
del /f/s/q "%stagingPath%" > nul
	::Remove the directory to clear out old subfolders (hackish I know)
	rmdir /s/q "%stagingPath%"

:: Copy files 
xcopy "%versionControlPath%\MAYHEM.Exile.Altis" "%stagingPath%\MAYHEM.Exile.Altis" /S /Y /I /Q

echo Folders Staged, Moving to compress

::Compressing Staged Files into PBOs
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\MAYHEM.Exile.Altis" "%stagingPath%\MAYHEM.Exile.Altis.pbo"

echo Moving Staged Files to Game Directory
copy "%stagingPath%\MAYHEM.Exile.Altis.pbo" "%testServerPath%\MPMissions\MAYHEM.Exile.Altis.pbo"

timeout 30
exit
