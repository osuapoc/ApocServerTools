@echo off
set pboConsolePath=C:\Program Files\PBO Manager v.1.4 beta

set stagingPath=C:\ARMA Editing\ExileMod\_VersionControlled\Staging
set versionControlPath=C:\ARMA Editing\ExileMod\_VersionControlled\Mayhem.Exile.Altis
set server1Path=Y:\_NewFileStaging
::set server2Path=Z:\_NewFileStaging

::Delete Already staged files
del /f/s/q "%stagingPath%" > nul
	::Remove the directory to clear out old subfolders (hackish I know)
	rmdir /s/q "%stagingPath%"


:: Copy files 
xcopy "%versionControlPath%\MAYHEM.Exile.Altis" "%stagingPath%\MAYHEM.Exile.Altis" /S /Y /I /Q

xcopy "%versionControlPath%\a3_dms" "%stagingPath%\a3_dms" /S /Y /I /Q
xcopy "%versionControlPath%\a3_infiSTAR_exile" "%stagingPath%\a3_infiSTAR_exile" /S /Y /I /Q
xcopy "%versionControlPath%\exile_server" "%stagingPath%\exile_server" /S /Y /I /Q
xcopy "%versionControlPath%\exile_server_config" "%stagingPath%\exile_server_config" /S /Y /I /Q
xcopy "%versionControlPath%\loot_addon" "%stagingPath%\loot_addon" /S /Y /I /Q
xcopy "%versionControlPath%\Exile_VEMF" "%stagingPath%\Exile_VEMF" /S /Y /I /Q
xcopy "%versionControlPath%\a3xai" "%stagingPath%\a3xai" /S /Y /I /Q
xcopy "%versionControlPath%\a3xai_config" "%stagingPath%\a3xai_config" /S /Y /I /Q
xcopy "%versionControlPath%\a3_zcp_exile" "%stagingPath%\a3_zcp_exile" /S /Y /I /Q

xcopy "%versionControlPath%\BattlEye" "%stagingPath%\BattlEye" /S /Y /I /Q
echo Folders Staged, Moving to compress

::Compressing Staged Files into PBOs
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\MAYHEM.Exile.Altis" "%stagingPath%\MAYHEM.Exile.Altis.pbo"

"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\a3_dms" "%stagingPath%\a3_dms.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\a3_infiSTAR_exile" "%stagingPath%\a3_infiSTAR_exile.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\exile_server" "%stagingPath%\exile_server.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\exile_server_config" "%stagingPath%\exile_server_config.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\loot_addon" "%stagingPath%\loot_addon.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\Exile_VEMF" "%stagingPath%\Exile_VEMF.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\a3xai" "%stagingPath%\a3xai.pbo"
"%pboConsolePath%\PBOConsole.exe" -pack "%stagingPath%\a3xai_config" "%stagingPath%\a3xai_config.pbo"
MakePbo.exe -p -@=x\addons\ZCP "%stagingPath%\a3_zcp_exile" "%stagingPath%\a3_zcp_exile.pbo"


echo Moving Staged Files to Game Directory
copy "%stagingPath%\MAYHEM.Exile.Altis.pbo" "%server1Path%\MAYHEM.Exile.Altis.pbo"
copy "%stagingPath%\a3_dms.pbo" "%server1Path%\a3_dms.pbo"
copy "%stagingPath%\a3_infiSTAR_exile.pbo" "%server1Path%\a3_infiSTAR_exile.pbo"
copy "%stagingPath%\exile_server.pbo" "%server1Path%\exile_server.pbo"
copy "%stagingPath%\exile_server_config.pbo" "%server1Path%\exile_server_config.pbo"
copy "%stagingPath%\loot_addon.pbo" "%server1Path%\loot_addon.pbo"
copy "%stagingPath%\Exile_VEMF.pbo" "%server1Path%\Exile_VEMF.pbo"
copy "%stagingPath%\a3xai.pbo" "%server1Path%\a3xai.pbo"
copy "%stagingPath%\a3xai_config.pbo" "%server1Path%\a3xai_config.pbo"
copy "%stagingPath%\a3_zcp_exile.pbo" "%server1Path%\a3_zcp_exile.pbo"
echo.
echo Files staged on Server 1 (66.150.214.11)
::copy "%stagingPath%\MAYHEM.Exile.Altis.pbo" "%server2Path%\MAYHEM.Exile.Altis.pbo"
::copy "%stagingPath%\a3_dms.pbo" "%server2Path%\a3_dms.pbo"
::copy "%stagingPath%\a3_infiSTAR_exile.pbo" "%server2Path%\a3_infiSTAR_exile.pbo"
::copy "%stagingPath%\exile_server.pbo" "%server2Path%\exile_server.pbo"
::copy "%stagingPath%\exile_server_config.pbo" "%server2Path%\exile_server_config.pbo"
::copy "%stagingPath%\loot_addon.pbo" "%server2Path%\loot_addon.pbo"
::copy "%stagingPath%\Exile_VEMF.pbo" "%server2Path%\Exile_VEMF.pbo"
::copy "%stagingPath%\a3xai.pbo" "%server2Path%\a3xai.pbo"
::copy "%stagingPath%\a3xai_config.pbo" "%server2Path%\a3xai_config.pbo"
echo.
::echo Files staged on Server 2 (66.150.214.11)
echo.

timeout 30