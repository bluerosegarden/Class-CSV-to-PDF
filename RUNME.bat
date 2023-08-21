@echo off
set /p "name=Enter a name for the document: "
.\typst.exe compile .\paper-classes.typ %name%.pdf
