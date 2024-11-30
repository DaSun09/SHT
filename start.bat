for /f "delims=" %%x in (version) do set Build=%%x
for /F %%I in ('curl https://raw.githubusercontent.com/DaSun09/SHT/main/version') do set Actual=%%I

set fileDir="C:\Program Files\SHT\"

if %Build% lss %Actual% (
  :CONFIRM
  set /P INPUT=Nova versao %Actual% encontrada. Deseja atualizar? [y/n]
  if /i "%PARAMVALUE%"=="y" goto updateY
  if /i "%PARAMVALUE%"=="n" goto started
  
  echo Resposta invalida!
  ping localhost -n 2 >nul
  cls
  goto CONFIRM
  
  :updateY
  "%fileDir%/updater/update.bat"
  exit /B
)

echo Nao foram encontradas nenhumas versoes mais recentes. Iniciando o programa.

ping 127.0.0.1 -n 5 > nul


:started
echo.
echo SHT (Sun's Hacking Tools) V1.0.0
echo.
echo Nenhuma opcao disponivel no momento
echo.
echo Pressione Enter para fechar o Prompt de Comando
pause >nul