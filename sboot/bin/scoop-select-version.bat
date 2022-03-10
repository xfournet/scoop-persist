@echo off

set APP_NAME=%1
set APP_VERSION=%2

if "%APP_NAME%" == "" (
  echo Missing application name parameter
  exit 1
)

if "%APP_VERSION%" == "" (
  echo Missing application version parameter. Choose one of the version below
  echo.
  dir /b %SCOOP%\apps\%APP_NAME% | grep -v current
  exit 1
)

set APP_CURRENT=%SCOOP%\apps\%APP_NAME%\current
set APP_TARGET=%SCOOP%\apps\%APP_NAME%\%APP_VERSION%

if not exist %APP_TARGET%\ (
  echo Scoop app '%APP_NAME%' version '%APP_VERSION%' doesn't exist
  exit 1
)

if exist %APP_CURRENT%\ (
  attrib -r /l %APP_CURRENT%
  junction -d %APP_CURRENT%
)

junction %APP_CURRENT% %APP_TARGET%
