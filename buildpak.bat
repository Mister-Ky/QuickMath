
@echo off
@for /f "tokens=2 delims==" %%A in ('findstr /b /c:"-D resourcesPath=" build.hxml') do set RESPATH=%%A
IF NOT "%~1"=="" set RESPATH=%~1
haxe -hl hxd.fmt.pak.Build.hl -lib heaps -main hxd.fmt.pak.Build
hl hxd.fmt.pak.Build.hl -res %RESPATH% -out %RESPATH%
