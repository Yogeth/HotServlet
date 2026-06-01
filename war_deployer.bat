@echo off
setlocal enabledelayedexpansion

if not exist "apache-tomcat-10.1.55" (
    echo Tomcat not found. Installing...
    curl -LO https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.55/bin/apache-tomcat-10.1.55.tar.gz
    tar -xzf apache-tomcat-10.1.55.tar.gz
    del /f apache-tomcat-10.1.55.tar.gz
)

set TOMCAT=.\apache-tomcat-10.1.55
set WAR_SOURCE=.\app\build\libs
set APP_NAME=HotServlet

rem --- FIX: Tomcat scripts require CATALINA_HOME as an absolute path ---
for %%i in ("%TOMCAT%") do set CATALINA_HOME=%%~fi

echo Stopping Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat" 2>nul || echo Tomcat was not running, continuing...

timeout /t 5 /nobreak >nul

echo Cleaning old deployment...
if exist "%CATALINA_HOME%\webapps\%APP_NAME%" rd /s /q "%CATALINA_HOME%\webapps\%APP_NAME%"
del /f /q "%CATALINA_HOME%\webapps\*.war" 2>nul

echo Building project...
call gradlew.bat clean build
if errorlevel 1 (
    echo Build failed!
    exit /b 1
)

set WAR_FILE=
for /f "delims=" %%f in ('dir /b /s "%WAR_SOURCE%\*.war" 2^>nul') do (
    if not defined WAR_FILE set WAR_FILE=%%f
)

if not defined WAR_FILE (
    echo WAR not found!
    exit /b 1
)

echo Deploying %WAR_FILE%...
copy "%WAR_FILE%" "%CATALINA_HOME%\webapps\"

echo Starting Tomcat...
call "%CATALINA_HOME%\bin\startup.bat"

echo Deployment complete.