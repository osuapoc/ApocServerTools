@echo off
::Enable Debug mode (pause and echo throughout batch; use TRUE and FALSE)
set DebugState="FALSE"
::Turn on Echoing if the debug state is TRUE
if %DebugState% == "TRUE" (echo on)

::Configuration of Operation

	::Paths for various things
		::Make sure to have a \ on serverPath - oddity in one of the lower commands requires it
		::set serverPath=			"D:\Arma 3 Exile\"
		set serverPath=			"G:\A3 Test Server\"

		:: Change these paths to match however you've configured your box, may not need any changing
		set serverSourcePath=	%serverPath%"@exileServer\addons"
		set missionSourcePath=	%serverPath%"MPMissions"
		::set beSourcePath=		%serverPath%"exile\BattlEye"
		set beSourcePath=		%serverPath%"_Exile\BattlEye"

		::Path to staging folder, where do you want to look for new files?
		::set stagingLocation=	%serverPath%"_NewFileStaging"
		set stagingLocation=	"C:\ARMA Editing\ExileMod\_VersionControlled\Staging"
		::Path to backups folder, where zip files will hold all current server files
		set backupLocationPath=	"C:\ARMA Editing\BatchTesting\Backup"
		::What do you call your mission file?
		set MissionFileName= 	"MAYHEM.Exile.Altis.pbo"

		::Path to your 7Zip executable
		set zipPath=			"C:\Program Files\7-Zip"
		::Path to your PBO Manager executable
		set PBOmanagerPath=		"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe"
	::Options
		::Delete staged files after copying to server?
		set DeleteStaged="TRUE"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::Check and see if anything is in the Staging folder
dir /b /a %stagingLocation%\* | >nul findstr "^" && (echo Files and/or Folders exist) || (goto :NothingExists)


::Get the local time and create a variable for naming the backup file
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%-%ldt:~8,2%-%ldt:~10,2%-%ldt:~12,2%
echo Local date is [%ldt%]

::Create an archive of the PBO files from the live server

	::Server Mod Files
	%zipPath%\7z a %backupLocationPath%\%ldt%_ServerFileBackup.zip %serverSourcePath%\*.pbo
	::Server Mission Files
	%zipPath%\7z a %backupLocationPath%\%ldt%_ServerFileBackup.zip %missionSourcePath%\*.pbo
	::Server Battleye Filters
	%zipPath%\7z a %backupLocationPath%\%ldt%_ServerFileBackup.zip %beSourcePath%
	::Server db connection File
	%zipPath%\7z a %backupLocationPath%\%ldt%_ServerFileBackup.zip %serverPath%\extdb-conf.ini
	::Server extDB Custom Commands File
	%zipPath%\7z a %backupLocationPath%\%ldt%_ServerFileBackup.zip %serverPath%\extDB\SQL_custom_v2\exile.ini

	echo Server files backed up as %backupLocationPath%\%ldt%_ServerFileBackup.zip

if %DebugState% == "TRUE" (pause)

::Check various Possible files in Staging folder for existence, remove live version
		::Add in any files that you are loading with the server below
		::Or, remove any that I am using that you are not

::Have folders that need PBO'd in the stage folder?
	setlocal EnableDelayedExpansion
	::Have to trim the "" marks from the staging path for all of the craziness
	set StagingPathTrim= %stagingLocation%
	for /f "useback tokens=*" %%a in ('%StagingPathTrim%') do set StagingPathTrim=%%~a

	::Now we'll go forth and find all the folders in the stage directory, and PBO them!
	cd %stagingLocation%
	FOR /D %%G in ("*") DO (
	        set "foldername=%%G"
	        set "strInput="!StagingPathTrim!\!foldername!""
	        set "strOutput="!StagingPathTrim!\!foldername!.pbo""
	        %PBOmanagerPath% -pack !strInput! !strOutput!
	        )
	endLocal
	echo All Done PBO'ing Folders!  (If any existed anyhow!)
if %DebugState% == "TRUE" (pause)

echo Now copying new files into the server from staging directory

	::ExileServer PBO
	set file=exile_server.pbo

	if exist %stagingLocation%\%file% (
		del %serverSourcePath%\%file%
		copy %stagingLocation%\%file% %serverSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)
	::ExileServerConfig PBO
	set file=exile_server_config.pbo

	if exist %stagingLocation%\%file% (
		del %serverSourcePath%\%file%
		copy %stagingLocation%\%file% %serverSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)
	:: :: :: :: :: Custom / Extra Addons :: :: :: :: :: ::

	::infiSTAR PBO
	set file=a3_infiSTAR_exile.pbo

	if exist %stagingLocation%\%file% (
		del %serverSourcePath%\%file%
		copy %stagingLocation%\%file% %serverSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)

	::DMS Mission System PBO
	set file=a3_dms.pbo

	if exist %stagingLocation%\%file% (
		del %serverSourcePath%\%file%
		copy %stagingLocation%\%file% %serverSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)

	::VEMF Mission System PBO
	set file=VEMF.pbo

	if exist %stagingLocation%\%file% (
		del %serverSourcePath%\%file%
		copy %stagingLocation%\%file% %serverSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)

	::Extra Loot System PBO
	set file=loot_addon.pbo

	if exist %stagingLocation%\%file% (
		del %serverSourcePath%\%file%
		copy %stagingLocation%\%file% %serverSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)

	:: :: :: :: :: Mission Folder :: :: :: :: :: ::

	::Have to trim the "" marks from the mission name for all of the craziness
	set MissionFileNameTrim= %MissionFileName%
	for /f "useback tokens=*" %%a in ('%MissionFileNameTrim%') do set MissionFileNameTrim=%%~a

	::Mission PBO
	set file=%MissionFileNameTrim%

	if exist %stagingLocation%\%file% (
		del %missionSourcePath%\%file%
		copy %stagingLocation%\%file% %missionSourcePath%\%file%
		if %DeleteStaged% == "TRUE" (del %stagingLocation%\%file%)
		echo Copied Staged %file% to server
		)

echo All Done with Staged Changes!

if %DebugState% == "TRUE" (pause)
timeout 5
::Don't fall through the lower NothingExists case!
goto :eof

::There was nothing to do!
:NothingExists
echo No Staged Files Found
timeout 5

if %DebugState% == "TRUE" (pause)
