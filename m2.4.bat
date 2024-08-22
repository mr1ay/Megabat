	@echo off 
	setlocal enabledelayedexpansion

	cls
	if "%~1"=="" (  set "fi=a"
	) else (        set "fi=%~n1"
	)

	set "file0=%fi%.txt"
	set "file1=%fi%_edit.mbat" 
 	set "file2=%fi%_.bat" 
 	set "yourcorefolder=Core"
 	set "yourmainfolder=C:\Users\%username%\Desktop"

	set "lockcomment=false"
	set "spacerule1=    "
	set "spacerule2=            "
	set "lockgotoeofspacerule=false" 
:::::::::::::::::::::::::::::::::::::::::::::::::::
	call :EditComputer  
	call :SpaceAdderComputer
		echo................
		type %file0%
		echo/
		echo................
		echo/
		type %file1%
		echo/
		echo................
		echo/
		type %file2%
		echo/
		echo................
		echo finished

	pause   
	goto :end

:://////////////////////////////////////////////////////////////////////////////////////////////

:EditComputer
	set "in_case_block=0"
	set "first_case=1"
	set "in_event=false"
	set "in_loop=false"
	set "buttoncoords="
	set "buttonhovers="
	set "setgui=false"
	set "setc=false"
 	set "case_num=0"
	set "last_arg="
	set "endrule=false"
	echo. converted lines
	timeout /t 1 >nul 
	echo.>%file1%

	for /f "tokens=* delims=" %%x in (%file0%) do ( set sentence=%%x 
		call :beta
	)
	goto :eof 

	:beta 
				call edit.bat !sentence!
		    	goto :eof

:://////////////////////////////////////////////////////////////////////////////////////////////
	:SpaceAdderComputer
				call spaceadder.bat
				goto :eof


	:end
	    	echo son
	    	timeout /t 1
