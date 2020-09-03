@echo off
setlocal enabledelayedexpansion


for /D %%d in (*) do (
	cd %%d
	for %%f in (*) do ren "%%f" "%%d_%%f"
	move /Y * ../
	cd ../
	del %%d
)

echo convert fit to gpx
for %%f in (*.fit) do (
	"C:\Program Files (x86)\GPSBabel\gpsbabel" -i garmin_fit -f "%%f" -o gpx -F "%%~nf.gpx"
	del %%f
)

echo rename gpx name
set /a number=0
for %%f in (*.gpx) do (
	ren "%%f" "!number!.gpx"
	set /a number+=1
)

echo done
pause