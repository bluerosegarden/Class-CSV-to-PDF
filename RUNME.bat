@echo off
setlocal
set first=1
echo Class To CSV Version 2.3.2

set /p "grouping=Do you want to group by professor name? (Y/N): "
if /i "%grouping%"=="Y" (
    echo Grouping Mode
)

set /p "name=Enter a name for the resulting PDF document: "
@echo off
setlocal enabledelayedexpansion

:: Check if there are multiple "classes*.csv" files in the current directory
set "fileCount=0"
for %%f in (classes*.csv) do (
    set /a "fileCount+=1"
)

:: Prompt user for confirmation
set /p "confirmation=There are multiple csv files that begin with 'classes'. Do you want to merge them together into one final PDF? Your original csv files will not be touched. (Y/N) "

if /i "%confirmation%"=="Y" (
    :: dont include the .csv here
    call ./MERGEFILES.bat "input.tmp"
    goto :process
    ) else (
    echo Merge cancelled, continuing with just classes.csv.
    if exist classes.csv (
        copy "classes.csv" "input.tmp.csv">nul
        goto :process
    ) else (
        echo Could not find "classes.csv", are you sure there's one in the folder?
        set /p "null=Press any button to exit"
        goto :end  
    )
)


:process
if /i "%grouping%"=="Y" (
    .\typst.exe compile .\grouped-paper-classes.typ "%name%".pdf
) else (
    .\typst.exe compile .\paper-classes.typ "%name%".pdf
)
del input.tmp.csv
echo %name%.pdf Generated!
set /p "null=Press any button to exit"
:end
