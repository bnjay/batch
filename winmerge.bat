:: Compare two files in a directory and produce an HTML report.

@echo off
set TEST_DIR=C:\Tools\test
set exe_file="C:\Tools\WinMerge\WinMergeU.exe"
set folder_count=0

rem Loop through all directories
setlocal enabledelayedexpansion

for /D %%G in (%TEST_DIR%\xxx.yyy.*) do (

set dir=%%G
rem echo !dir!
set /a folder_count=folder_count+1

rem Check files in each directory

set left_folder=""
set right_folder=""
set file_count=0

@echo off

setlocal enabledelayedexpansion
set too_many_files=false

for /f %%i in ('dir /b /s !dir!') do (
  if !file_count! == 2 call:error !dir!
  rem echo %%i
  
  if !left_folder! == "" (
    set left_folder=%%i
  ) else if !right_folder! == "" (
    set right_folder=%%i
  )
  set /a file_count=file_count+1
  rem echo !file_count! !left_folder! !right_folder!
)

@echo off

rem set left_folder="C:\Tools\test\xxxyyyzzz\Excel_conversion_macro_example_test.xlsm"
rem set right_folder="C:\Tools\test\xxxyyyzzz\Excel_conversion_macro_example2_test.xlsm"

rem echo !left_folder!
rem echo !right_folder!

if exist !dir!_diff.html del !dir!_diff.html

if !too_many_files! == false start /wait "" !exe_file! /r /wl /wr !left_folder! !right_folder! -minimize -noninteractive -u -x -or !dir!_diff.html & call:check_diff_report !dir!_diff.html

)

echo(
echo(
echo Finished all %folder_count% folders.

exit /b

:error
echo(
echo(
echo Too many files found in the directry %1
set too_many_files=true
exit /b

:check_diff_report

echo(
echo(
echo "Checking the diff report" %1

findstr href %1 
if %errorlevel% equ 0 echo "Diff found" & start chrome.exe file://%1

exit /b


