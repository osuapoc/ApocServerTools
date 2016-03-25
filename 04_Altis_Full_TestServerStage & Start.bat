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
copy "%stagingPath%\MAYHEM.Exile.Altis.pbo" "%testServerPath%\MPMissions\MAYHEM.Exile.Altis.pbo"

copy "%stagingPath%\a3_dms.pbo" "%testServerPath%\@ExileServer\addons\a3_dms.pbo"
copy "%stagingPath%\a3_infiSTAR_exile.pbo" "%testServerPath%\@ExileServer\addons\a3_infiSTAR_exile.pbo"
copy "%stagingPath%\exile_server.pbo" "%testServerPath%\@ExileServer\addons\exile_server.pbo"
copy "%stagingPath%\exile_server_config.pbo" "%testServerPath%\@ExileServer\addons\exile_server_config.pbo"
copy "%stagingPath%\loot_addon.pbo" "%testServerPath%\@ExileServer\addons\loot_addon.pbo"
copy "%stagingPath%\Exile_VEMF.pbo" "%testServerPath%\@ExileServer\addons\Exile_VEMF.pbo"
copy "%stagingPath%\a3xai.pbo" "%testServerPath%\@ExileServer\addons\a3xai.pbo"
copy "%stagingPath%\a3xai_config.pbo" "%testServerPath%\@ExileServer\addons\a3xai_config.pbo"
copy "%stagingPath%\a3_zcp_exile.pbo" "%testServerPath%\@ExileServer\addons\a3_zcp_exile.pbo"
::timeout 30

cd "%testServerPath%"
timeout 1
start "arma3" /min "%testServerPath%\arma3server.exe" -port=2302 -autoinit "-config=_Exile\config.cfg" "-cfg=_Exile\basic.cfg" "-profiles=_Exile" "-name=_Exile"  -servermod=@ExileServer -mod=@Exile 
::timeout 10
echo ARMA 3 Server has started
timeout 2

