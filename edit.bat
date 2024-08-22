@echo off
set "sentence=%*"

			::yorum kısmı
				set "B=!sentence:~0,2!"
			    set "BB=!sentence:~2!"

			    if "%B%"=="//"  echo.::  !BB!>> %file1%                      			&& goto :eof
			    if "%B%"=="/*"  echo.::/*>> %file1% && set "lockcomment=true"  		    && goto :eof
			    if "%B%"=="*/"  echo.::*/>> %file1% && set "lockcomment=false"			&& goto :eof

if  "!sentence:~0,3!"=="set" echo.!sentence!>> %file1%&& goto :eof
			::import kısmı
				if  "!sentence:~0,7!"=="importt"  call :importfileblock !sentence:~7! && goto :eof 
				if  "!sentence:~0,6!"=="import"   call :importblock !sentence:~6! && goto :eof 
 
			::

if "!setvideo!"=="true" if "%sentence:~0,5%"=="merge" call :videomerge && goto :eof

if "!setpc!"=="true"   (

if "!sentence:~0,5!"=="light" echo.nircmd setbrightness !sentence:~5!  >> %file1%  && goto :eof
if "!sentence:~0,5!"=="sound" echo.set /a volume= !sentence:~5! * 655 >> %file1%   && echo.nircmd setvolume 0 %%%%volume%%%% %%%%volume%%%%  >> %file1% && goto :eof
)

if "!setdefault!"=="true"   (
if "!sentence:~0,19!"=="defaultimageprogram" call :defaultimageprogram  && goto :eof
)


if "!setbrowser!"=="true"   (
if "!sentence:~0,7!"=="browser"  echo.call :browser !sentence:~7!  >> %file1% && goto :eof
)


if "!setc!"=="true" (
				if  "!sentence:~0,4!"=="eeee" echo.@echo off >> %file1%            && goto :eof
				if  "!sentence:~0,3!"=="eee"  echo.@echo on  >> %file1%            && goto :eof
				
				set "B=!sentence:~0,2!"  
				if  "!B!"=="xy"  echo.cmdwiz setwindowpos !sentence:~2! >> %file1%              && goto :eof
				if  "!B!"=="ti"  if not "!sentence:~2,1!"=="i" echo.title !sentence:~2! >> %file1%  && goto :eof
				if  "!B!"=="cc"  echo.color !sentence:~2! >> %file1%                            && goto :eof
				set "B=!sentence:~0,1!" 
				if  "!B!"=="m" if "!B:~1,1!"==""  echo.mode  !sentence:~1! >> %file1%  && goto :eof
				if  "!B!"=="c" if "!B:~1!"==""  echo.cls >> %file1%  		         && goto :eof
			)

if "!setoto!"=="true" (

					set "B=!sentence:~0,2!"
					set "BB=!sentence:~2!" 
					if "%B%"=="kk"  echo.nircmd sendkeypress %BB%>> %file1% 	&& goto :eof
					if "%B%"=="kc"  echo.nircmd clipboard set %BB%>> %file1% 	&& goto :eof
					if "%B%"=="kv"  echo.nircmd sendkeypress ctrl+v>> %file1% 	&& goto :eof
					if "%B%"=="ke"  echo.nircmd sendkeypress enter>> %file1% 	&& goto :eof
					if "%B%"=="k-" echo.nircmd sendkeypress %BB%>> %file1% 	&& goto :eof
					if "%B%"=="m-" echo.mouse %BB%>> %file1%               	&& goto :eof
					::mm sonra nircmd olarak?
					if "%B%"=="mm" echo.mouse %BB%>> %file1%               	&& goto :eof
					if "%B%"=="n-" echo.nircmd %BB%>> %file1%              	&& goto :eof
					if "%B%"=="ni" echo.nircmd %BB%>> %file1%              	&& goto :eof
					::light ı bağla buraya 
					if "%B%"=="l-" echo.nircmd %BB%>> %file1%              	&& goto :eof


 
)



			::switch case kısmı 
				set "B=%sentence:~0,3%" 
				set "BB= %sentence:~3%" 
				if  "!sentence:~0,7!" == "default" call :defaultblock 	 && goto :eof
				if  "!sentence:~0,6!" == "switch" call :switchblock 	 && goto :eof
				if  "!sentence:~0,4!" == "case" call :caseblock 		 && goto :eof
				if  "!sentence:~0,5!" == "break" call :breakblock 		 && goto :eof
			::

			::loop kısmı

				if  "!sentence:~0,4!"=="loop"    call :loopblock !sentence:~4! && goto :eof 
				if  "!sentence:~0,4!"=="endl"   (
												set "in_loop=false" 
												echo.set /a varloop += 1 >> %file1%
												echo.goto :loop>> %file1%
												echo.:loop_end>> %file1%  
												goto :eof
												)

			::batbox kısmı

				set "B=!sentence:~0,2!" 
				set "BB=!sentence:~2!" 
				if "%B%"=="ee" if not "%BB%"=="" call :batt %BB% 			&& goto :eof



			::gui block
				if "!sentence:~0,9!"=="buttongui"  echo.getinput /m %buttoncoords% /h %buttonhovers% >>%file1% && goto :eof
				if "!sentence:~0,6!"=="button"  call :buttonblock !sentence:~6! && goto :eof

				set "B=!sentence:~0,5!"
				set "B=!B: =!"
				if "!B!"=="event" echo.if %%%%errorlevel%%%% == !sentence:~5! ( >>%file1%   && set "in_event=true" && goto :eof
				set "B=!sentence:~0,4!"  
				if "!B!"=="ende"  set "in_event=false" && echo.}>>%file1% && goto :eof
							 




 
				if  "!sentence:~0,1!"=="p"	  echo.pause }*{ >> %file1%           && goto :eof
				set "B=%sentence:~0,4%"
				set "BB=%sentence:~4%"
				set "BBB=%BB:~0,2%"
				::
				::seta ve set p ye bak 
				if  "%B%"=="setp"	echo.set /p %BB% >> %file1%                 && goto :eof
				if  "%B%"=="seta"	echo.set /a %BB% >> %file1%                 && goto :eof
				if  "%B%"=="ifne"	echo.if not exist %BB%  >> %file1%  		&& goto :eof
				if  "%B%"=="ifnd"	echo.if not defined %BB% >> %file1%  		&& goto :eof
				if  "%B%"=="ifnt"	echo.if not true == %%!BB!%% >> %file1%     && goto :eof
				if  "%B%"=="ifnf"	echo.if not false == %%!BB!%% >> %file1%  	&& goto :eof
				if  "%B%"=="tiii"	echo.timeout /t !BB! }*{  >> %file1%  	    && goto :eof
				if  "%B%"=="lang"   if  "%BB%"=="tr"	echo.chcp 65001 }*{  >> %file1%  	&& goto :eof
				::
				set "B=%sentence:~0,3%" 
				set "BB=%sentence:~3%" 
				if  "%B%"=="tii"	echo.timeout /t !BB!>> %file1%  		              && goto :eof
				if  "%B%"=="sed"	echo.SetLocal EnableDelayedExpansion>> %file1%  	  && goto :eof
				if  "%B%"=="sdd"	echo.SetLocal DisableDelayedExpansion>> %file1% 	  && goto :eof
				if  "%B%"=="see"	echo.SetLocal EnableExtensions>> %file1%        	  && goto :eof
				if  "%B%"=="sde"	echo.SetLocal DisableExtensions>> %file1%       	  && goto :eof
				if  "%B%"=="mdd"	echo.md %BB% >> %file1% && echo.cd /d %BB% >> %file1% && goto :eof
				if  "%B%"=="ife"	echo.if exist %BB% >> %file1%  				&& goto :eof
				if  "%B%"=="ifd"	echo.if defined %BB% >> %file1%  			&& goto :eof
				if  "%B%"=="ift"	echo.if true == %%BB%% >> %file1%  			&& goto :eof
				if  "%B%"=="iff"	echo.if false == %%BB%% >> %file1%  		&& goto :eof
				if  "%B%"=="eof"	echo.goto :eof >> %file1%  		&& goto :eof
				if  "%sentence:~0,4%"=="endd"    if "%sentence:~4%"==""	 set "endrule=true"		&& goto :eof
				if  "%B%"=="end"    			if "%BB%"==""	echo.goto :end >> %file1%  && goto :eof
				::
				set "B=!sentence:~0,1!"
				set "BB=!sentence:~2,4!"
				if  "!B!"=="c"	if "!BB!"=="eeee" echo.@echo off >> %file1%              && goto :eof
				::
				set "BB=!sentence:~2,2!"
				set "BBB=!sentence:~4!"
				if  "!B!"=="c"	if "!BB!"=="ti"  echo.title !BBB! >> %file1%              && goto :eof
				if  "!B!"=="c"	if "!BB!"=="cc"  echo.color !BBB! >> %file1%              && goto :eof
				if  "!B!"=="c"	if "!BB!"=="xy"  echo.cmdwiz setwindowpos !BBB! >> %file1% && goto :eof
				if  "!B!"=="c"	if "!sentence:~2,3!"=="eee" echo.@echo on >> %file1%                  && goto :eof
				::
				set "BB=!sentence:~2,1!"
				set "BBB=!sentence:~4!"
				if  "!B!"=="c"	if "!BB!"=="m"      echo.mode  !BBB! >> %file1%     && goto :eof
				if  "!B!"=="c"	if "!BB!"=="c"      echo.cls >> %file1%  		    && goto :eof 
				if  "!B!"=="c"	if "!BB!"=="t"      echo.title !BBB! >> %file1%     && goto :eof
				::if "!BB!"==" " 
				set "B=!sentence:~0,2!"
				set "BB=!sentence:~2!"
				if "%B%"=="ti" echo.title %BB%>> %file1%              		&& goto :eof
				if "%B%"=="pp" echo.pause >> %file1%              	    	&& goto :eof
				if "%B%"==":." echo.goto :%BB% >> %file1%              	    && goto :eof
				::

				if "!in_event!"=="true" echo.!sentence!>>%file1% &&   goto :eof
			    if !lockcomment!==true  echo.:: !sentence!>> %file1%  	&& goto :eof


				echo.!sentence! >> %file1%  && goto :eof
	
goto :eof

/////////////////////////// defaultimageprogram

				:defaultimageprogram
						echo.ftype MyFileType=%%%%SystemRoot%%%%\System32\rundll32.exe "C:\Program Files\Windows Photo Viewer\PhotoViewer.dll" ImageView_Fullscreen %%%%1>>%file1%
						echo.assoc .jpg=MyFileType>>%file1%
						echo.assoc .png=MyFileType>>%file1%
						goto :eof

/////////////////////////// video

				:videomerge
						echo.file '1.mp4'>filelist.txt
						echo.file '2.mp4'>>filelist.txt
						echo.echo. created empety file name list>> %file1%
						echo.echo.fill list file>> %file1%
						echo.set FILELIST=filelist.txt>> %file1%
						echo.set OUTPUT=output.mp4>> %file1%
						echo.ffmpeg -f concat -safe 0 -i %%%%FILELIST%%%% -c copy %%%%OUTPUT%%%%>> %file1%
						goto :eof





/////////////////////////// gui kısmı


				:buttonblock
						set "count=0"
						set "lastarg="
						echo.>>%file1%
						for %%a in (%*) do  set /A count+=1 &&  if !count! gtr 8 set "lastarg=!lastarg! %%a"
						call :spacebuttonn  !lastarg!
						echo.batbox /g %1 %2 /c 0x%7 /d "!arg!" >>%file1%
						set buttoncoords=!buttoncoords! %3 %4 %5 %6
						set buttonhovers=!buttonhovers! %8  
						goto :eof

				:spacebuttonn
						set "arg=%*"
						goto :eof





//////////////////////////// batbox kısmı

:batt
		set arg=%*
		set clean=!arg:%1=!
		set clean1=!clean:%2=!
		set clean2=!clean1:%3=!
		set clean3=!clean2:%4=!

		if "%1"=="0"    echo.batbox /g %2 %3             >> %file1% 
		if "%1"=="1"    echo.batbox /c 0x%2              >> %file1% 
		if "%1"=="2"    call :batspace !clean! &&echo.batbox /d "!arg!"           >> %file1% 
		if "%1"=="01"   echo.batbox /g %2 %3 /c 0x%4     >> %file1% 
		if "%1"=="02"   call :batspace !clean2! &&echo.batbox /g %2 %3 /d "!arg!">> %file1% 
		if "%1"=="12"   call :batspace !clean1! &&echo.batbox /c 0x%2 /d "!arg!" >> %file1% 
		if "%1"=="012"  call :batspace !clean3! &&echo.batbox /g %2 %3  /c 0x%4 /d  "!arg!" >> %file1% 
		goto :eof


:batspace
		set "arg=%*"
		goto :eof



//////////////////////////////// loop kısmı


	:loopblock 
		echo.set varloop=%1  >>%file1%
		echo.:loop >>%file1% 
		echo.if  %%%%varloop%%%%  == %2 goto :loop_end>>%file1% 
		set "in_loop=true"
		goto :eof






//////////////////////////////// switch case area

:switchblock
		set "fix=!sentence:switch=!"
		set "fix=!fix:)=!"
		set "fix=!fix:(=!"
		set "switchvar=!fix!"
		set "switchvar=!switchvar: =!"
		echo set sw = %%%%!switchvar!%%%% >> "%file1%"
		echo.  >> "%file1%"
		goto :eof

:caseblock

		set "case_num=!sentence:~4!"

		if "!first_case!" == "1" (
			echo if %%%%sw%%%% == !case_num! {{>> "%file1%"
			set "in_case_block=1"
			set "first_case=0"
			goto :eof

			) 
		if "!first_case!" == "0" echo.} else if %%%%sw%%%% == !case_num! {{>> "%file1%" &&set "in_case_block=1"
		
		goto :eof

:defaultblock 

		echo } else { >> "%file1%"
		set "in_case_block=1"

		goto :eof

:breakblock

		if "!in_case_block!" == "1"  echo.} >> "%file1%" && echo. >> "%file1%" &&   set "in_case_block=0"
		goto :eof

//////////////////////////////// import area
 
:importblock
		set "arg=%*"
		for %%A in (%arg%) do set "set%%A=true"	
		if "%setgui%"=="true"    if not exist !yourmainfolder!\getinput.exe    copy !yourcorefolder!\getinput.exe  !yourmainfolder!
		if "%setgui%"=="true"    if not exist !yourmainfolder!\batbox.exe      copy !yourcorefolder!\batbox.exe    !yourmainfolder!
		if "%setoto%"=="true"    if not exist !yourmainfolder!\nircmd.exe      copy !yourcorefolder!\nircmd.exe    !yourmainfolder!
		if "%setvideo%"=="true"  if not exist !yourmainfolder!\ffmpeg.exe      copy !yourcorefolder!\ffmpeg.exe    !yourmainfolder!
		 
		if "%setpc%"=="true"  if not exist !yourmainfolder!\nircmd.exe      copy !yourcorefolder!\nircmd.exe    !yourmainfolder!


		goto :eof

:importfileblock 
		set "arg=%*"
		for %%A in (%arg%) do  if not exist !yourmainfolder!\%%A    copy !yourcorefolder!\%%A  !yourmainfolder!
		goto :eof