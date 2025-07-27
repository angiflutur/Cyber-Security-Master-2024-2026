@echo off
setlocal

rem === Configuration ===
set "JDK_HOME=C:\Program Files\Java\jdk-17"
set "SIM_JAR=%~dp0lib\jcardsim-3.0.6.0.jar"
set "CLS=%~dp0classes"
set "SRC=%~dp0main"

echo === Compiling (delta) HostAppEmulator ===
"%JDK_HOME%\bin\javac.exe" ^
    -encoding UTF-8 ^
    -classpath "%SIM_JAR%;%CLS%" ^
    -d "%CLS%" ^
    "%SRC%\HostAppEmulator.java"

echo === Running HostAppEmulator ===
"%JDK_HOME%\bin\java.exe" ^
    -classpath "%SIM_JAR%;%CLS%" ^
    main.HostAppEmulator

pause
