@ECHO OFF
echo Pressione enter para continuar a desinstalacao de SHT
pause >nul
echo Procurando arquivos...
cd "C:\Program Files\SHT\"
for %%a in (*) do goto foundFile
echo Ocorreu um erro ao tentar encontrar os arquivos.
goto eof

:foundFile
echo Excluindo %1

:eof
echo Fechando programa.
pause
exit \B