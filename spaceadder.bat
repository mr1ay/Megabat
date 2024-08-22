@echo off
set "sentence=%*"

			:: Her satırı oku (Read to All Line)
			echo.!spacerule2!::%time:~0,8%  %date:~4%>%file2%
			echo.!spacerule2!::Edited by Megabat >>%file2%
			echo.!spacerule2!::Thanks mr1ay >>%file2%
			echo.!spacerule2!::v1.0 >>%file2% 
		
			echo.!spacerule2!>>%file2%
			::if "!setlength!"=="true" echo.%spacerule2%@set "length=0">>%file2%
	 
			if "!setreplace!"=="true" echo.%spacerule2%setlocal enabledelayedexpansion>>%file2%
			for /f "delims=" %%a in (%file1%) do call :delta %%a

			if "!setlength!"=="true" call :copylength
			if "!setreplace!"=="true" call :copyreplace
			if "!setbrowser!"=="true" call :copybrowser
			if "!endrule!"=="true" echo.>>%file2% && echo.!spacerule1!:end>>%file2% 
 
			goto:eof


:delta 
			set last=%* 
			set "C=!last:~0,1!"
			set "lastt=!last:~0,9%!" 
		    if "%lockgotoeofspacerule%"=="true"       if "!lastt!"=="goto :eof"      echo.%spacerule2%!last!>> %file2%    &&   echo.>> %file2% &&	goto :eof       
		    if "%gate%"=="true"  set "spacerule2=                "
		    if "%gate%"=="false" set "spacerule2=            "
	 
			if "!last:~0,2!"=="::" echo.%spacerule2%!last!>> %file2% && goto :eof

			if "%C%"==":"  echo.%spacerule1%!last!>> %file2% && goto :eof
	    	if "%C%"=="}"   set last=!last:}=)!

			call :lastargu %*

			if "%C%"==" " 	goto :eof

			if not "%C%"==" " (
						set "last=!last:}*{=>nul!" 
						set last=!last:'=%%!
						set last=!last:{=(!
						echo.%spacerule2%!last!>> %file2%
						goto :eof
			)
			goto :eof


:lastargu 
			for %%a in (%*) do ( 
					set "first_argu=%1"
					set "last_argu=%%a"
			) 
			if "!last_argu!"=="{"  set "gate=true" 
			if "!last_argu!"=="("  set "gate=true" 
			if "!first_argu!"=="}" set "gate=false"
			goto :eof
	  
:copylength 
	 
		setlocal disabledelayedexpansion

		echo.   >>%file2%
		echo.%spacerule2%:length   >>%file2%
		echo.%spacerule2%%spacerule2%setlocal enabledelayedexpansion   >>%file2%
		echo.%spacerule2%%spacerule2%set "numbera=%%1"   >>%file2%
		echo.%spacerule2%%spacerule2%set "length=0"   >>%file2%
		echo.   >>%file2%

		echo.%spacerule2%:loop  >>%file2%
		echo.%spacerule2%%spacerule2%if "!numbera!"=="" goto :endlength   >>%file2%
		echo.%spacerule2%%spacerule2%set /a length+=1   >>%file2%
		echo.%spacerule2%%spacerule2%set "numbera=!numbera:~1!"   >>%file2%
		echo.%spacerule2%%spacerule2%goto :loop   >>%file2%
		echo.   >>%file2%

		echo.%spacerule2%:endlength   >>%file2%
		echo.%spacerule2%%spacerule2%endlocal ^& set "length=%%length%%"   >>%file2%
		echo.%spacerule2%%spacerule2%goto :eof   >>%file2%
		setlocal enabledelayedexpansion

		goto :eof



:copyreplace
		setlocal disabledelayedexpansion
		echo.   >>%file2%
		echo.%spacerule1%:replace>>%file2%
		echo.%spacerule2%set replace=%%1>>%file2%
		set y=%%3!
		echo.%spacerule2%set replace=!replace:%%2=%y%>>%file2%
		echo.%spacerule2%goto :eof>>%file2%
		setlocal enabledelayedexpansion
		goto :eof

:copybrowser	
		echo.>>%file2%
		echo.%spacerule1%:browser>>%file2%
		echo.%spacerule2%C:\Users\%%username%%\AppData\Local\Yandex\YandexBrowser\Application\browser.exe --incognito %%1>>%file2%
		echo.%spacerule2%goto :eof>>%file2%
		goto :eof