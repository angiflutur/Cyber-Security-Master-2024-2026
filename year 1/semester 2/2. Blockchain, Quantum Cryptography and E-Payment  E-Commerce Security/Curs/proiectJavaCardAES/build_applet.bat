@echo off
setlocal

rem ============ Configuration ============
set "JDK_HOME=C:\Program Files\Java\jdk-17"
set "JCDK_DIR=C:\java_card_devkit_tools-bin-v25.0-b_470-23-APR-2025"

set "ROOT=%~dp0"
set "SRC=%ROOT%main"

rem ---- Output directories ----
set "CLS_APPLET=%ROOT%classes"   rem AESApplet classes output
set "CLS_HOST=%ROOT%classes"    rem Host emulator classes output

if not exist "%CLS_APPLET%" mkdir "%CLS_APPLET%"
if not exist "%CLS_HOST%"  mkdir "%CLS_HOST%"

echo === Compiling AESApplet.java for Java Card ===
"%JDK_HOME%\bin\javac.exe" ^
    -g -source 1.7 -target 1.7 ^
    -classpath "%JCDK_DIR%\lib\*" ^
    -encoding UTF-8 ^
    -d "%CLS_APPLET%" ^
    "%SRC%\AESApplet.java"

echo === Converting to CAP file for Java Card ===
pushd "%JCDK_DIR%\bin"
converter.bat ^
  -classdir "%CLS_APPLET%" ^
  -applet 0xa0:0x00:0x00:0x00:0x62:0x12:0x34 main.AESApplet ^
  main 0xa0:0x00:0x00:0x00:0x62:0x12:0x35 1.0 ^
  -out CAP -verbose
popd

echo === Compiling HostAppEmulator.java ===
"%JDK_HOME%\bin\javac.exe" ^
    -encoding UTF-8 ^
    -classpath "%ROOT%lib\jcardsim-3.0.6.0.jar;%CLS_APPLET%" ^
    -d "%CLS_HOST%" ^
    "%SRC%\HostAppEmulator.java"

echo Build completed successfully 
pause
