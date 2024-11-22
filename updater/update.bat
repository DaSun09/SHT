@ECHO OFF
:: Solicita por permissoes administrativas
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Solicitando permissoes administrativas...
    goto UACPrompt
) else ( goto gotAdmin )

:gotAdmin
:: Vai para o destino de instalacao
cd "C:\Program Files"

echo Inicializando download de SHT (Sun's Hacking Tools)
pause
cls

:: Checa se Git existe, caso contrario, o instala.
if not exist "%USERPROFILE%\AppData\Local\Programs\Git" (
    if not exist "C:\Program Files\Git" (
        echo Nao foi possivel encontrar o programa Git.
        echo Inicializando instalacao do programa.
        pause
        winget install --id Git.Git -e --source winget
    )
)

:: Checa se o aplicativo nao existe
:: Erro impossivel

if not exist "C:\Program Files\SHT\" (
    cls
    echo Nao foi possivel encontrar a versao atual do aplicativo. Erro desconhecido
    pause
    exit /B
)

echo Desinstalando a versao anterior
pause
rd /s /q "C:\Program Files\SHT\"
echo Instalando a versao atualizada

:: Inicializa a instalacao
git clone https://github.com/DaSun09/SHT.git

:: Checa se houve um erro com a instalacao
if not exist "C:\Program Files\SHT\start.bat" if not exist "C:\Program Files\SHT\version" (
    cls
    echo Ocorreu um erro ao tentar criar o atalho do arquivo
    pause
    exit /B
)

mkdir "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SunHackingTools\"

:: Cria um atalho global no Menu Iniciar
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SunHackingTools\Launch.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "C:\Program Files\SHT\start.bat" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs

cscript CreateShortcut.vbs
del CreateShortcut.vbs

:: Cria um atalho local no Menu Iniciar
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\SHT.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "C:\Program Files\SHT\start.bat" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs

cscript CreateShortcut.vbs
del CreateShortcut.vbs
goto Done

:Done
cls
echo Atualizacao concluida.
pause
exit /B

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B