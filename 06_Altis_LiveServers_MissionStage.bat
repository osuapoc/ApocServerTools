@echo off
set pboConsolePath=C:\Program Files\PBO Manager v.1.4 beta

set stagingPath=C:\ARMA Editing\ExileMod\_VersionControlled\Staging
set versionControlPath=C:\ARMA Editing\ExileMod\_VersionControlled\Mayhem.Exile.Altis
set server1Path=Y:\_NewFileStaging
::set server2Path=Z:\_NewFileStaging

::Delete Already staged files
del "%stagingPath%\MAYHEM.Exile.Altis" /Q
del "%stagingPath%\MAYHEM.Exile.Altis.pbo" /Q

:: Copy files 
xcopy "%versionControlPath%\MAYHEM.Exile.Altis" "%stagingPath%\MAYHEM.Exile.Altis" /S /Y /I /Q

echo Folders Staged, Moving to compress

::Compressing Staged Files into PBOs
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\MAYHEM.Exile.Altis" "%stagingPath%\MAYHEM.Exile.Altis.pbo"

echo Moving Staged Files to Game Directory
copy "%stagingPath%\MAYHEM.Exile.Altis.pbo" "%server1Path%\MAYHEM.Exile.Altis.pbo"
echo.
echo Files staged on Server 1 (66.150.214.11)
::copy "%stagingPath%\MAYHEM.Exile.Altis.pbo" "%server2Path%\MAYHEM.Exile.Altis.pbo"
echo.
::echo Files staged on Server 2 (66.150.214.11)
echo.

timeout 30