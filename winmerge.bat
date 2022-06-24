@echo off
rem Compare two files in a directory and produce an HTML report.
rem
rem If there are more than two files the directory is skipped.
rem An HTML report is produced even if there is no difference. However,
rem Chrome won't open it. You can adjust the naming patterns for directories
rem and files.
rem
rem Dependencies: WinMerge and Chrome
rem 

@echo off
set TEST_DIR=C:\Tools\test
set DIR_PATTERNS=xxx.yyy.*
set FILE_PATTERNS=*example*
set EXE_FILE=C:\Tools\WinMerge\WinMergeU.exe
set folder_count=0
set skipped_folder_count=0

rem Loop through all directories
setlocal enabledelayedexpansion

for /d %%G in (%TEST_DIR%\%DIR_PATTERNS%) do (

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

for /f "delims=" %%i in ('dir /b /s !dir!\!FILE_PATTERNS!') do (
  if !file_count! == 2 call:error !dir!
  rem echo %%i
  
  if !left_folder! == "" (
    set left_folder="%%i"
  ) else if !right_folder! == "" (
    set right_folder="%%i"
  )
  set /a file_count=file_count+1
  rem echo !file_count! !left_folder! !right_folder!
)

@echo off

rem echo(
rem echo !left_folder!
rem echo !right_folder!

if exist !dir!_diff.html del !dir!_diff.html

if !too_many_files! == false start /wait "" !EXE_FILE! /r /wl /wr ""!left_folder!"" ""!right_folder!"" -minimize -noninteractive -u -x -or !dir!_diff.html & call:check_diff_report !dir!_diff.html

)

echo(
echo(
echo Checked %folder_count% folders and skipped %skipped_folder_count%.

exit /b

:error
echo(
echo(
echo Too many files found in the directry %1
set too_many_files=true
set /a skipped_folder_count=skipped_folder_count+1
exit /b

:check_diff_report

echo(
echo(
echo "Checking the diff report" %1
echo(

findstr href %1 
if %errorlevel% equ 0 echo "Diff found" & start chrome.exe file://%1

exit /b


