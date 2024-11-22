for /f "delims=" %%x in (version) do set Build=%%x
for /F %%I in ('curl https://raw.githubusercontent.com/DaSun09/SHT/main/version') do set Actual=%%I

set fileDir="C:\Program Files\SHT\"

if %Build% lss %Actual% (
  "%fileDir%/updater/update.bat"
  exit /B
)