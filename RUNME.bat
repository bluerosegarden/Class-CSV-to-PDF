@echo off
setlocal
set first=1
set /p "name=Enter a name for the resulting PDF document: "
@echo off
setlocal enabledelayedexpansion

:: Check if there are multiple "classes*.csv" files in the current directory
set "fileCount=0"
for %%f in (classes*.csv) do (
    set /a "fileCount+=1"
)
if %fileCount% lss 2 (
    if exist classes.csv (
        copy "classes.csv" "temp_merged.csv.tmp">nul
        goto :process
    ) else (
        echo Could not find "classes.csv", are you sure there's one in the folder?
        goto :end  
    )
)
:: Prompt user for confirmation
set /p "confirmation=There are multiple csv files that begin with 'classes'. Do you want to merge them together into one final PDF? Your original csv files will not be touched. (Y/N) "

if /i "%confirmation%"=="Y" (
    :: Create an empty "temp_merged.csv" file
    type nul > "temp_merged.csv.tmp"

    :: Merge all "classes*.csv" files into "temp_merged.csv" without headers
    for %%f in (classes*.csv) do (
        if "%%f" neq "temp_merged.csv.tmp" (
            type "%%f" | more +1 >> "temp_merged.csv.tmp"
        )
    )
    echo Merging all csv files that begin with "classes"
    goto :process
) else (
    echo Merge cancelled, continuing with just classes.csv.
    if exist classes.csv (
        copy "classes.csv" "temp_merged.csv.tmp"
        goto :process
    ) else (
        echo Could not find "classes.csv", are you sure there's one in the folder?
        goto :end  
    )
)

:process
.\typst.exe compile .\paper-classes.typ "%name%".pdf
del temp_merged.csv.tmp
echo %name%.pdf Generated!
:end
