@echo off
rem ***********************************************************
rem * ODE Windows Release Script
rem * Originally written by Jason Perkins (starkos@gmail.com)
rem *
rem * Prerequisites:
rem *  Command-line svn installed on path
rem *  Command-line zip installed on path
rem *  Run within Visual Studio command prompt
rem ***********************************************************

rem * Check arguments
if "%1"=="" goto show_usage
if "%2"=="" goto show_usage


rem ***********************************************************
rem * Pre-build checklist
rem ***********************************************************

echo. 
echo STARTING PREBUILD CHECKLIST, PRESS ^^C TO ABORT.
echo.
echo Is the version number "%1" correct?
pause
echo.
echo Have you created a release branch named "%2" in SVN?
pause
echo.
echo Have you run all of the tests?
pause
echo.
echo Is the Changelog up to date?
pause
echo.
echo Okay, ready to build the Windows binary package for version %1!
pause


rem ***********************************************************
rem * Prepare source code
rem ***********************************************************

echo.
echo RETRIEVING SOURCE CODE FROM REPOSITORY...
echo.

rem svn co https://svn.sourceforge.net/svnroot/opende/branches/%1 ode-%1
copy ode-%1\build\config-default.h ode-%1\include\ode\config.h


rem ***********************************************************
rem * Build the binaries
rem ***********************************************************

echo.
echo BUILDING RELEASE BINARIES...
echo.

cd ode-%1\build\vs2003
rem devenv.exe ode.sln /build DebugLib /project ode
rem devenv.exe ode.sln /build DebugDLL /project ode
rem devenv.exe ode.sln /build ReleaseLib /project ode
rem devenv.exe ode.sln /build ReleaseDLL /project ode


rem ***********************************************************
rem * Package things up
rem ***********************************************************

cd ..\..\..
rename lib\ReleaseDLL\ode.lib lib\ReleaseDLL\ode-imports.lib
zip -r9 ode-win32-%1.zip ode-%1\*.txt ode-%1\include\ode\*.h ode-%1\lib\* -x ode-%1\lib\.svn\*


rem ***********************************************************
rem * Clean up
rem ***********************************************************

rmdir /s /q ode-%1
goto done


rem ***********************************************************
rem * Error messages
rem ***********************************************************

:show_usage
echo Usage: msw_release.bat version_number branch_name
goto done

:done