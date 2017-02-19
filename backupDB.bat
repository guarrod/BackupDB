 @echo off

 set dbUser=root
 set dbPassword=
 set "backupDir=C:\xampp\htdocs\backup"
 set "mysqldump=C:\xampp\mysql\bin\mysqldump.exe"
 set "mysqlDataDir=C:\xampp\mysql\data"
 set "zip=C:\Program Files\7-Zip\7z.exe"
 

 :: http://stackoverflow.com/a/31789045/1010918 foxidrive's answer helped me get the folder with the date and time I wanted

rem The four lines below will give you reliable YY DD MM YYYY HH Min Sec MS variables in XP Pro and higher.

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%" & set "MS=%dt:~15,3%"

 set "dirname=BackupDB_%YYYY%-%MM%-%DD% %HH%-%Min%-%Sec%"

 :: remove echo here if you like
 echo "dirName"="%dirName%"

 :: switch to the "data" folder
 pushd "%mysqlDataDir%"

 :: create backup folder if it doesn't exist
 if not exist "%backupDir%\%dirName%\" mkdir "%backupDir%\%dirName%"

 :: iterate over the folder structure in the "data" folder to get the databases

 for /d %%f in (*) do (
 :: remove echo here if you like
 echo processing folder "%%f"

 "%mysqldump%" --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases %%f > "%backupDir%\%dirName%\%%~nxf.sql"

 "%zip%" a -tgzip "%backupDir%\%dirName%\%%~nxf.sql.gz" "%backupDir%\%dirName%\%%~nxf.sql"

  del "%backupDir%\%dirName%\%%~nxf.sql"

 )
 popd

 :: delete all folders but the latest 2


 :: http://stackoverflow.com/a/17521693/1010918 Magoo's answer helped me get what I wanted to do with the folders
 :: for /f "skip=2 delims=" %G in ('dir /B /ad-h /o-d') DO echo going to delete %G

 :: below following my version with rd (remove dir) command and /s and /q
 :: remove echo before rd to really delete the folders in question!!
 :: attention they will be deleted with content in them!!

 :: change the value after skip= to what you like, this is the amount of latest folders to keep in your backup directory
    for /f "skip=2 delims=" %%a in (' dir "%backupDir%\" /b /ad-h /o-d') do echo rd /s /q "%backupDir%\%%a"

:: remove pause here if you like and add the file to Windows Task Manager
 pause