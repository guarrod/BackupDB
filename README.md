# BackupDB

Script para el respaldo de las bases de datos en Xampp con Windows

## Para configurar este script de respaldo es necesario seguir los siguientes pasos

1. Ubicar el archivo backupDB.bat en algun sitio dentro del disco principal del sistema, en lo personal lo ubico dentro de /htdocs
2. Instalar 7-zip desde http://www.7-zip.org
3. Abrir el archivo con un editor de texto o Notepad++ 
4. Ubicar las siguientes lineas y modificar según los comentarios

```
set dbUser=root                                      REM Si usas Xampp en Windows dejar asi
set dbPassword=                                      REM Mismo comentario que el anterior
set "backupDir=C:\xampp\htdocs\backup"               REM Crea y ubica dentro de /htdocs u otra ubicación donde se harán los respaldo, en ese caso creé y vincule una carpeta /backup dentro de /htdocs
set "mysqldump=C:\xampp\mysql\bin\mysqldump.exe"     REM Ubicar el ejecutable mysqldump.exe y vincularlo, si usas Windows dejar esta linea tal cual.
set "mysqlDataDir=C:\xampp\mysql\data"              REM Misco comentario que el anterior, se trata de ubicar la carpeta /data
set "zip=C:\Program Files\7-Zip\7z.exe"             REM Indicar la ruta de llegada al ejecutable 7z.exe de la instalación del 7-zip
```

5. Este archivo de respaldo está configurado para generar una carpeta de nombre "BackupDB_YYYY-MM-DD HH-MM-SS" e internamente un comprimido con el nombre de la base de datos conteniendo un .sql de la misma.


## Automatizar la ejecución del respaldo

Adicional a esto puedes configurar la ejecución diaria de este script para generar un respaldo diario de las bases de datos

###### Instrucciones
 
 1. Hacer click en inicio y teclear "Programador de Tareas" hacer clic en el acceso que da como resultado
 2. Hacer clic en Acción/Crear Tarea
 3. Hacer clic en la pestaña "Desencadenadores" y luego clic en Nuevo
 4. En esta nueva ventana configurar cada cuanto se ejecutará esta tarea Ej: Diariamente, Inicio "dia actual" y setear a que hora se desea ejecutar la tarea diariamente "9:00pm"
 5. Hacer clic en Aceptar
 6. Hacer clic en la pestaña "Acciones" y luego en Nueva
 7. En la opción "Acción" seleccionar Iniciar un Programa
 8. En Programa o script hacer clic en Examinar y buscar y hacer clic al archivo backupDB.bat y luego en Abrir y luego en Aceptar
 9. Listo con esto está configurada la ejecución del respaldo
 10. Adicionalmente se recomienda poner un nombre a la tarea en la pestaña "General" y hacer clic en Aceptar para guardar y cerrar el programador.
 
> Al ejecutarse la tarea aparecerá una ventana CDM con el log de la tarea en curso, aún me falta añadirle una instrucción para que se cierre automaticamente :)
