@echo off
setlocal
set first=1
set /p "name=Enter a name for the merged CSV file: "
@echo off
setlocal enabledelayedexpansion

:: Check if there are multiple "classes*.csv" files in the current directory
set "fileCount=0"
for %%f in (classes*.csv) do (
    set /a "fileCount+=1"
)
if %fileCount% lss 2 (
    if exist classes.csv (
        echo Could not find more than one csv file that begins with "classes", are you sure there's multiple in the folder?
        set /p "null=press any button to quit"
        goto :end
    ) else (
        echo Could not find "classes.csv", are you sure there's one in the folder?
        set /p "null=press any button to quit"
        goto :end  
    )
)

    :: Create an empty "temp_merged.csv" file
    type nul > "%name%.csv"

    :: Merge all "classes*.csv" files into "temp_merged.csv" without headers
    >%name%.csv (
        for %%F in (classes*.csv) do (
        if defined first (
        type "%%F"
        set "first="
        ) else more +1 "%%F"
    )
    )
    
)

echo %name%.csv Generated!
:end
