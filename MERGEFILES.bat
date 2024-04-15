@echo off
setlocal
set first=1

if [%1] == [] (
    set /p "name=Enter a name for the merged CSV file: "
) else (
    set name=%*
)

setlocal enabledelayedexpansion

:: Check if there are multiple "classes*.csv" files in the current directory
set "fileCount=0"
for %%f in (classes*.csv) do (
    set /a "fileCount+=1"
)
if %fileCount% lss 2 (
    if %fileCount% == 1 (
        echo Could only find 1 csv file that begins with "classes". Are you sure there's multiple in the folder?
        set /p "null=press any button to quit"
        goto :end
    ) else (
        echo Could not find any csv files that begin with "classes", are you sure there's any in the folder?
        set /p "null=press any button to quit"
        goto :end  
    )
)

    :: Create an empty "Class_CSV_to_PDF.tmp.csv" file
    type nul > "Class_CSV_to_PDF.tmp.csv"

    :: Merge all "classes*.csv" files into "Class_CSV_to_PDF.tmp.csv" without headers
    >Class_CSV_to_PDF.tmp.csv (
        for %%F in (classes*.csv) do (
            if defined first (
                type "%%F"
                set "first="
                echo:
            ) else more +1 "%%F"
        )
    )


if NOT [Class_CSV_to_PDF.tmp] == "%name%" (
ren "./Class_CSV_to_PDF.tmp.csv" "%name%.csv"
)


echo %name%.csv Generated!
:end
