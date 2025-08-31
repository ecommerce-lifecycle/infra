@echo off
setlocal EnableDelayedExpansion

cd /d %~dp0

REM *******************************************
REM *********   Docker Maintenance   **********
REM *******************************************

call :printHeader "Stopping and Removing Containers"
docker-compose down -v

REM Delete local data folders if exist
rmdir /s /q kafka-data
rmdir /s /q zookeeper-data
rmdir /s /q postgres-data

call :printHeader "Rebuilding Images (No Cache)"
docker-compose build --no-cache

call :printHeader "Starting Containers"
docker-compose up -d

echo.
echo All done successfully!
pause
exit /b 0

:printHeader
echo.
echo ****************************************************************
echo **********                                            **********
echo    		%~1
echo **********                                            **********
echo ****************************************************************
echo.
exit /b 0
