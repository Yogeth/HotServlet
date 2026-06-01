@echo off
setlocal EnableDelayedExpansion

REM Install Tomcat if missing
if not exist "apache-tomcat-10.1.55" (
echo Tomcat not found. Installing...

```
powershell -Command "Invoke-WebRequest -Uri 'https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.55/bin/apache-tomcat-10.1.55.zip' -OutFile 'apache-tomcat-10.1.55.zip'"

powershell -Command "Expand-Archive -Path 'apache-tomcat-10.1.55.zip' -DestinationPath '.'"

del /q apache-tomcat-10.1.55.zip
```

)

set TOMCAT=apache-tomcat-10.1.55
set WAR_SOURCE=app\build\libs
set APP_NAME=HotServlet

echo Stopping Tomcat...
call "%TOMCAT%\bin\shutdown.bat"

timeout /t 5 /nobreak >nul

echo Cleaning old deployment...

if exist "%TOMCAT%\webapps%APP_NAME%" (
rmdir /s /q "%TOMCAT%\webapps%APP_NAME%"
)

del /q "%TOMCAT%\webapps*.war" 2>nul

echo Building project...
call gradlew.bat clean build

if errorlevel 1 (
echo Build failed!
exit /b 1
)

set WAR_FILE=

for %%f in ("%WAR_SOURCE%*.war") do (
set WAR_FILE=%%f
goto found
)

echo WAR not found!
exit /b 1

:found

echo Deploying !WAR_FILE!...
copy "!WAR_FILE!" "%TOMCAT%\webapps" >nul

echo Starting Tomcat...
call "%TOMCAT%\bin\startup.bat"

echo Deployment complete.

endlocal
