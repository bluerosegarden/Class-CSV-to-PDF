# README

This is the repository for the bookmarklet & [tyspt](https://typst.app/) template to generate a CSV file from the Johnson County Community College's Class Search!

Simply copy all the text in [this file](bookmarklet.js) and add it as a new bookmark, preferably in your bookmark's bar! To look at a non-minified and actually readable version of the code, check out the full file [here](bookmarklet-full.js)!

⚠️ For Safari, you'll need to do the following:
1. Go to Safari > Preferences > Advanced and enable Show Develop menu in menu bar.
2. Go to Develop and enable Allow JavaScript from Smart Search field.


This uses [Tysp](https://typst.app/) to format the class.csv file that you get from the bookmarklet! The Tyspt.exe binary is not created by me. Everything else is however!


Optionally, the script will ask if you want to merge all the csv files that begin with "classes" that are in the folder into a single CSV! Also, included is a seperate .bat file called MERGEFILES.bat that will *only* automatically merge all of the csv files for you!

No need to install anything or run anything as admin! Just do the following things:


0. make sure any csv or pdf files you want to keep are moved out of this folder!
1. Acquire a class.csv of the classes you want (use the bookmarklet js code in bookmarket.js on the JCCC site!)
2. put the classes.csv file in this folder (named exactly!!) (You can also add multiple CSV files to the folder to be compiled into one pdf at the end! However they must all start with "classes", so `classes.csv`, `classes2.csv`, `classes(3).csv`, and `classesalphabetaomega.csv` will all work!)
3. doubleclick on the bat file and give the file a name (without the `.pdf` part of the name!)
4. open your new PDF! (and move to a new location!)


The following files must be present to work:
- RUNME.bat
- paper-classes.typ
- typst.exe
- classes.csv


Everything else can be deleted if needed!
